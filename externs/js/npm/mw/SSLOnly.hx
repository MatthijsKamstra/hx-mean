package externs.js.npm.mw;

import externs.js.npm.express.Request;
import externs.js.npm.express.Response;
import externs.js.npm.express.Next;
import js.node.Os;
using StringTools;

class SSLOnly {
  public static function create() : Request -> Response -> Next -> Void {
    return function(req : Request, res : Response, next : Next) {
      var isHttps = req.secure;

      // check for heroku
      if (!isHttps) {
        isHttps = req.headers["x-forwarded-proto"] == "https";
      }

      if (isHttps) {
        return next.call();
      }

      // it is localhost, ignore SSL
      if (Os.hostname().endsWith(".local")) {
        return next.call();
      }

      // Only redirect GET requests, all others end with 403
      if (req.method == "GET") {
        res.redirect(301, "https://" + req.headers["host"] + req.originalUrl);
      } else {
        res.status(403).send("Please use HTTPS when submitting data to this server");
      }
    }
  }
}
