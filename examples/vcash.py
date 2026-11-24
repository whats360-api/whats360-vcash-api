"""Placeholders only. Not run against the live service. Standard library only."""
import json, os, urllib.parse, urllib.request

BASE = "https://whats360.live/api/v1/vcash"

def call(method, path, body=None):
    headers = {"Authorization": "Bearer " + os.environ["WHATS360_TOKEN"], "Content-Type": "application/json"}
    data = json.dumps(body).encode() if body is not None else None
    req = urllib.request.Request(BASE + path, data=data, headers=headers, method=method)
    with urllib.request.urlopen(req) as r:
        return json.loads(r.read().decode())

def list_devices():
    return call("GET", "/devices")

def send_sms(device_id, recipient, message, sim_slot=1):
    return call("POST", "/sms/send", {"device_id": device_id, "recipient": recipient, "message": message, "sim_slot": sim_slot})

def balance(device_id):
    return call("GET", "/balance?device_id=" + urllib.parse.quote(device_id))
