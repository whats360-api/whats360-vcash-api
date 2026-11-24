// Placeholders only. Not run against the live service. Node 18+.
const BASE = 'https://whats360.live/api/v1/vcash';
const headers = { Authorization: `Bearer ${process.env.WHATS360_TOKEN}`, 'Content-Type': 'application/json' };

export async function listDevices() {
  return (await fetch(`${BASE}/devices`, { headers })).json();
}
export async function sendSms(deviceId, recipient, message, simSlot = 1) {
  const res = await fetch(`${BASE}/sms/send`, { method: 'POST', headers,
    body: JSON.stringify({ device_id: deviceId, recipient, message, sim_slot: simSlot }) });
  return res.json();
}
export async function balance(deviceId) {
  return (await fetch(`${BASE}/balance?device_id=${encodeURIComponent(deviceId)}`, { headers })).json();
}
// executeUssd is intentionally not provided as a ready function: it can move money.
