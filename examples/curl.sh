#!/usr/bin/env bash
# Placeholders only. Not run against the live service. Do NOT run the USSD call on a real account.
: "${WHATS360_TOKEN:?set WHATS360_TOKEN}"
BASE="https://whats360.live/api/v1/vcash"
AUTH="Authorization: Bearer $WHATS360_TOKEN"

# List devices
curl -H "$AUTH" "$BASE/devices"

# Send SMS through a connected device
curl -X POST -H "$AUTH" -H "Content-Type: application/json" "$BASE/sms/send" \
  -d '{"device_id":"DEVICE_ID","recipient":"01000000000","message":"Test message","sim_slot":1}'

# Balance summary
curl -H "$AUTH" "$BASE/balance?device_id=DEVICE_ID"

# USSD (commented out on purpose: may move money depending on the command)
# curl -X POST -H "$AUTH" -H "Content-Type: application/json" "$BASE/ussd/execute" \
#   -d '{"device_id":"DEVICE_ID","command":"YOUR_USSD_CODE","sim_slot":1}'
