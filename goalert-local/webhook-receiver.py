from datetime import datetime, timezone
from http.server import BaseHTTPRequestHandler, HTTPServer
import json


class Handler(BaseHTTPRequestHandler):
    def _log(self, body: bytes) -> None:
        ts = datetime.now(timezone.utc).isoformat(timespec="seconds")
        print(f"\n{'=' * 70}", flush=True)
        print(f"[{ts}]  {self.command} {self.path}", flush=True)
        print(f"{'-' * 70}", flush=True)
        for header, value in self.headers.items():
            print(f"{header}: {value}", flush=True)
        print(f"{'-' * 70}", flush=True)
        if body:
            try:
                parsed = json.loads(body)
                print(json.dumps(parsed, indent=2), flush=True)
            except json.JSONDecodeError:
                print(body.decode("utf-8", errors="replace"), flush=True)
        print(f"{'=' * 70}\n", flush=True)

    def do_POST(self):
        length = int(self.headers.get("Content-Length", "0"))
        body = self.rfile.read(length) if length else b""
        self._log(body)
        self.send_response(204)
        self.end_headers()

    def do_GET(self):
        self._log(b"")
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(b'{"status":"ok"}')

    def log_message(self, format, *args):
        return  # silence the default access log


if __name__ == "__main__":
    port = 9000
    print(f"Webhook receiver listening on :{port}", flush=True)
    HTTPServer(("0.0.0.0", port), Handler).serve_forever()