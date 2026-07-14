import http from 'k6/http';
import { check, sleep } from 'k6';

export default function() {
  const url = __ENV.URL || 'https://apigate.aphp.online/api/v1/demo-go/external';
  
  const params = {
    headers: {
      'Content-Type': 'application/json',
      'User-Agent': 'k6-load-test',
    },
    timeout: '10s',
  };

  const response = http.get(url, params);
  
  // Validate response
  const result = check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
    'response has body': (r) => r.body.length > 0,
  });
  
  // Think time between requests
  sleep(__ENV.SLEEP || 0.1);
}
