#!/bin/bash
set -e

# Inject environment variables into config
envsubst < config.template.yaml > config.yaml

echo "Config generated from template."
echo "Starting Hermes gateway..."

# Start a tiny HTTP server in background on port 8080
# This is what UptimeRobot will ping to keep Render awake
python3 -c "
import http.server, threading

class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b'Hermes is alive')
    def log_message(self, *args):
        pass  # suppress access logs

server = http.server.HTTPServer(('0.0.0.0', 8080), Handler)
t = threading.Thread(target=server.serve_forever, daemon=True)
t.start()
print('Pinger HTTP server running on port 8080')
" &

# Start Hermes gateway
exec hermes gateway --config config.yaml
