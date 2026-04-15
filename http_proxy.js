// Local HTTP proxy for the Unity 6 reborn UberStrike client.
//
// Listens on http://127.0.0.1:8888 (configurable via PROXY_LISTEN_PORT) and
// forwards every request to the configured upstream host. Default upstream is
// 127.0.0.1:5000 — the local UberStrok v4.8.6 ASP.NET Core WebServices stack
// running on your machine via UBZ Private Testing Server. Override via
// environment variables to point at a different backend.
//
// Why a proxy when Unity can speak HTTP natively:
//   - decouples the game binary from the upstream host (URL changes never
//     touch Assembly-CSharp.dll)
//   - logs every request for debugging the auth/web flow
//   - easy local-mock pivot when iterating
//
// Note: this proxy is HTTP only — both client→proxy and proxy→upstream legs
// are plaintext. Despite the historical name "tls_proxy" used in earlier
// commits, it never terminated TLS. File renamed to http_proxy.js to avoid
// implying TLS termination.
//
// Usage:
//   node http_proxy.js
//
// Override defaults:
//   set UBERSTRIKE_UPSTREAM_HOST=127.0.0.1
//   set UBERSTRIKE_UPSTREAM_PORT=5000
//   set PROXY_LISTEN_PORT=8888
//   node http_proxy.js
//
// Then in the client, set:
//   ApplicationDataManager.WebServiceBaseUrl = "http://127.0.0.1:8888/2.0/"
//   ApplicationDataManager.ImagePath        = "http://127.0.0.1:8888/images/"

const http = require('http');

const UPSTREAM_HOST = process.env.UBERSTRIKE_UPSTREAM_HOST || '127.0.0.1';
const UPSTREAM_PORT = parseInt(process.env.UBERSTRIKE_UPSTREAM_PORT || '5000', 10);
const LISTEN_PORT   = parseInt(process.env.PROXY_LISTEN_PORT || '8888', 10);

const server = http.createServer((req, res) => {
    const options = {
        hostname: UPSTREAM_HOST,
        port: UPSTREAM_PORT,
        path: req.url,
        method: req.method,
        headers: {
            ...req.headers,
            host: `${UPSTREAM_HOST}:${UPSTREAM_PORT}`,
        },
    };
    delete options.headers['connection'];
    delete options.headers['transfer-encoding'];

    console.log(`[PROXY] ${req.method} ${req.url}`);

    const proxyReq = http.request(options, (proxyRes) => {
        console.log(`[PROXY]   -> ${proxyRes.statusCode}`);
        res.writeHead(proxyRes.statusCode, proxyRes.headers);
        proxyRes.pipe(res, { end: true });
    });

    proxyReq.on('error', (err) => {
        console.error(`[PROXY ERROR] ${err.message}`);
        res.writeHead(502);
        res.end('Proxy error: ' + err.message);
    });

    req.pipe(proxyReq, { end: true });
});

server.listen(LISTEN_PORT, '127.0.0.1', () => {
    console.log(`[PROXY] Listening on http://127.0.0.1:${LISTEN_PORT}`);
    console.log(`[PROXY] Forwarding to http://${UPSTREAM_HOST}:${UPSTREAM_PORT}`);
});
