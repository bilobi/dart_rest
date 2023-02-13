import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  Middleware get middleware {
    return createMiddleware(responseHandler: (Response res) {
      return res.change(headers: {'Content-Type': 'application/json'});
    });
  }
}
