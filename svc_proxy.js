// svc_proxy.js — path-rewriting proxy for the Unity 4.6.5 reconstruction of the
// 4.7.1 client (UberSteam-client-4-7-1-unity465).
//
// WHY THIS EXISTS
// ---------------
// The AssetRipper reconstruction's SoapClient posts to the ORIGINAL Cmune WCF
// service names, verbatim:
//
//   SoapClient.MakeRequest(iface, "UberStrike.DataCenter.WebService.CWS.ShopWebServiceContract.svc", ...)
//   -> new WWW(Configuration.WebserviceBaseUrl + serviceName, ...)     // no transformation
//
// so it requests
//   http://127.0.0.1:8888/2.0/UberStrike.DataCenter.WebService.CWS.ShopWebServiceContract.svc
//
// The community UberStrok ASP.NET Core server (both xavgru12's and our fork)
// registers its SOAP endpoints under short names instead:
//
//   app.UseSoapEndpoint<ShopWebService>("/2.0/ShopWebService", ...)
//
// Result: every web service call 404s. The visible symptom is
// "ShopWebServiceClient.GetShop returned with NULL" and a completely empty item
// catalog — which means no item ever has ID >= 9007, so the weapon-skin hooks in
// Avatar / WeaponSlot / ProxyItem can never fire.
//
// tls_proxy.js next to this file forwards 8888 -> 5000 VERBATIM (it is a traffic
// logger), so it does not solve this. This one rewrites the path.
//
// Fixing it here rather than in the client keeps the reconstruction faithful to
// the shipped assembly, and rather than in the server avoids a rebuild — which
// would copy main.json (CopyToOutputDirectory=Always) and ship
// server_game_version 4.8.11 over the 4.8.6 the built catalog currently carries.
//
// USAGE
//   node svc_proxy.js
// with the web service already listening on 127.0.0.1:5000.

const http = require('http');

const UPSTREAM_HOST = '127.0.0.1';
const UPSTREAM_PORT = 5000;
const LISTEN_PORT = 8888;
const VERBOSE = process.argv.includes('--verbose');

// /2.0/UberStrike.DataCenter.WebService.CWS.<Name>WebServiceContract.svc
//   -> /2.0/<Name>WebService
const SVC_RE = /^\/2\.0\/UberStrike\.DataCenter\.WebService\.CWS\.(\w+)WebServiceContract\.svc$/;

function rewrite(path) {
    const m = SVC_RE.exec(path);
    return m ? `/2.0/${m[1]}WebService` : path;
}

const server = http.createServer((req, res) => {
    const chunks = [];
    req.on('data', (c) => chunks.push(c));
    req.on('end', () => {
        const body = Buffer.concat(chunks);
        const target = rewrite(req.url);
        if (target !== req.url) {
            console.log(`[REWRITE] ${req.url}  ->  ${target}`);
        } else if (VERBOSE) {
            console.log(`[PASS]    ${req.method} ${req.url}`);
        }

        const headers = { ...req.headers };
        delete headers['connection'];
        delete headers['transfer-encoding'];
        headers['host'] = `${UPSTREAM_HOST}:${UPSTREAM_PORT}`;
        if (body.length) headers['content-length'] = body.length;

        const proxyReq = http.request(
            { host: UPSTREAM_HOST, port: UPSTREAM_PORT, method: req.method, path: target, headers },
            (proxyRes) => {
                const respChunks = [];
                proxyRes.on('data', (c) => respChunks.push(c));
                proxyRes.on('end', () => {
                    const respBody = Buffer.concat(respChunks);
                    if (proxyRes.statusCode !== 200 || VERBOSE) {
                        console.log(`[PROXY]   -> ${proxyRes.statusCode} (${respBody.length} bytes) ${target}`);
                    }
                    const h = { ...proxyRes.headers };
                    delete h['transfer-encoding'];
                    h['content-length'] = respBody.length;
                    res.writeHead(proxyRes.statusCode, h);
                    res.end(respBody);
                });
            }
        );

        proxyReq.on('error', (err) => {
            console.error(`[PROXY ERROR] ${err.message}  (${target})`);
            res.writeHead(502);
            res.end('Proxy error: ' + err.message);
        });

        if (body.length) proxyReq.write(body);
        proxyReq.end();
    });
});

server.listen(LISTEN_PORT, '127.0.0.1', () => {
    console.log(`[PROXY] listening  http://127.0.0.1:${LISTEN_PORT}`);
    console.log(`[PROXY] forwarding http://${UPSTREAM_HOST}:${UPSTREAM_PORT}`);
    console.log(`[PROXY] rewriting  /2.0/UberStrike.DataCenter.WebService.CWS.<X>WebServiceContract.svc -> /2.0/<X>WebService`);
});
