<?php
// Placeholders only. NOT executed. Needs the curl extension.
function whats360_vcash(string $method, string $path, ?array $body = null): string {
    $ch = curl_init('https://whats360.live/api/v1/vcash' . $path);
    $headers = ['Authorization: Bearer ' . getenv('WHATS360_TOKEN'), 'Content-Type: application/json'];
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_HTTPHEADER => $headers, CURLOPT_CUSTOMREQUEST => $method]);
    if ($body !== null) curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($body));
    return curl_exec($ch);
}
echo whats360_vcash('GET', '/devices');
echo whats360_vcash('POST', '/sms/send', ['device_id' => 'DEVICE_ID', 'recipient' => '01000000000', 'message' => 'Test message', 'sim_slot' => 1]);
echo whats360_vcash('GET', '/balance?device_id=DEVICE_ID');
