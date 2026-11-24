# Whats360 VCash API (SMS and USSD through a connected phone)

REST endpoints for the **VCash / e-wallet** service in [Whats360](https://whats360.live): list connected VCash devices, send an SMS through a connected device, run a USSD command, and read a balance summary.

> Documentation derived from the Whats360 dashboard developer pages. The Whats360 owner states the documented endpoints are tested and working. **The examples in this repository were not executed against the live service by the person who wrote them.** Code is illustrative, uses placeholders only, and was not executed unless a test is listed. Whats360 links WhatsApp numbers by QR code. It is not the Meta Cloud API, not a Business Solution Provider, and not affiliated with or endorsed by Meta. No delivery or ban-avoidance guarantees.

> **Money and SIM warning.** The USSD endpoint runs a command on a real SIM. Depending on the command it can query a balance or move money. Never run it from an example against a real account. Use a test device and read your carrier's terms first. This repository documents the endpoint only. It does not execute real transactions.

Base URL: `https://whats360.live`  
Auth: HTTP header `Authorization: Bearer YOUR_API_TOKEN` (the dashboard shows the token under Developers (API) and can renew it). Note: the WhatsApp message endpoints in [whats360-api-docs](https://github.com/whats360-api/whats360-api-docs) take the token as a query parameter. This VCash page documents the Bearer header.

## Endpoints (from the dashboard page)
| Function | Method and path | Body or query |
|---|---|---|
| List VCash devices | GET /api/v1/vcash/devices | none |
| Send SMS | POST /api/v1/vcash/sms/send | JSON: device_id, recipient, message, sim_slot |
| Execute USSD | POST /api/v1/vcash/ussd/execute | JSON: device_id, command, sim_slot |
| Balance summary | GET /api/v1/vcash/balance | query: device_id |

Sample responses shown in the dashboard docs:
- Devices: `devices[]` with id, name, status, device_model, sim1_carrier, sim1_number, is_enabled, last_seen (unix seconds).
- SMS send: `success`, `message`, `sms_id`.
- USSD execute: `success`, `command_id`, `status` ("pending"), `message`.
- Balance: `total_income`, `total_expense`, `net_balance`, `transaction_count`, `currency`.

All values in [examples](examples) are placeholders (`abc123`, `01012345678`). The dashboard sample uses example data only.

## Examples
- [cURL](examples/curl.sh), [JavaScript](examples/vcash.js), [PHP](examples/vcash.php), [Python](examples/vcash.py)
- [OpenAPI draft](openapi.yaml)

## Gaps (not documented, not invented here)
Error response format for these endpoints, rate limits, how a USSD result is delivered after `pending` (polling endpoint or webhook), SIM slot values beyond `1`, plan requirements. See [DOCUMENTATION_GAPS.md](DOCUMENTATION_GAPS.md).

Support: https://wa.me/whats360.live · info@whats360.live · https://whats360.live
