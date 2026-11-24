# whats360.live VCash API (SMS and USSD through a connected phone)

REST endpoints for the **VCash / e-wallet** service in [whats360.live](https://whats360.live): list connected VCash devices, send an SMS through a connected device, run a USSD command, and read a balance summary.

> Documentation derived from the whats360.live dashboard developer pages. The whats360.live owner states the documented endpoints are tested and working. **The examples in this repository were not executed against the live service by the person who wrote them.** Code is illustrative, uses placeholders only, and was not executed unless a test is listed. whats360.live links WhatsApp numbers by QR code. It is not the Meta Cloud API, not a Business Solution Provider, and not affiliated with or endorsed by Meta. No delivery or ban-avoidance guarantees.

> **Money and SIM warning.** The USSD endpoint runs a command on a real SIM. Depending on the command it can query a balance or move money. Never run it from an example against a real account. Use a test device and read your carrier's terms first. This repository documents the endpoint only. It does not execute real transactions.

> Reading wallet SMS or USSD results is not an official bank or wallet-provider verification. No integration with a payment provider is documented, so do not treat balances or transactions here as provider-verified.

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

WhatsApp: https://wa.me/whats360.live · Direct chat support: https://wa.me/201030741766 · info@whats360.live · https://whats360.live

## Dashboard setup guide (summary)

Source: whats360.live dashboard "VCash user guide" page, seen in a dashboard PDF export dated 2026-05-27 (p33). Describes dashboard behaviour, not an API contract. Not independently verified.

1. Install the VCash Gateway Android app (APK download link is in the dashboard) and grant the SMS, notification and background permissions it asks for. Sign in with your platform account.
2. In the dashboard open VCash devices, add a device with a name, then scan the QR code from the app. The status should change to connected. The phone and the platform need network access.
3. Sender filter (device settings): enter a sender name such as a wallet provider's sender ID. The app forwards only messages whose sender contains that text. Leave it empty to forward all messages.
4. Incoming SMS tab: lists received messages with amount, sender and date. A manual SMS send is also available.
5. Message patterns: add or edit regex patterns that extract amount, phone number, transaction ID and name, and are applied to each incoming SMS to create a transaction. You can test a pattern on a real message before saving.

6. USSD commands tab: type a command, choose the device and SIM slot, and run it. The guide says the network reply is returned automatically and a PIN dialog is filled from the device settings if you saved a PIN. The API pages only show status `pending` for the API call, so result delivery through the API is not documented here.
7. USSD campaigns: a command template with variables such as the phone and the amount, plus a list with one `number,amount` pair per line. Commands run one after another. A campaign can be paused and resumed.
8. USSD scenarios: multi-step sequences. A step is a USSD command or a 2-second wait, and you can define variables such as phone and amount.
9. Accounts: lists recorded transactions, with filters by device, type (income or expense) and date. A transaction is recorded when an SMS arrives and matches a pattern.
10. Security: each device has its own token, so do not share it. The guide says the USSD PIN is stored encrypted and is not sent by SMS. A device can be disabled from the dashboard without deleting it, for example when a phone is lost.

Steps 6 to 10 come from the owner-supplied "VCash user guide" PDF (Telegram upload, Nov 2026). Dashboard behaviour as described there, not tested.

This reads wallet notification SMS on your own device. It is not bank or provider verification.
