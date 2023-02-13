import 'package:backend/infrastructure/dependecy_injectors/injects.dart';
import 'package:shelf/shelf.dart';

import 'package:backend/apis/index.dart';
import 'package:backend/infrastructure/custom_server.dart';
import 'package:backend/infrastructure/middleware_interception.dart';
import 'package:backend/utils/env/env.dart';

void main() {
  final di = Injects.initialize();

  //Requestleri sarmalıyor
  var cascadeHandlers = Cascade()
      .add(di.get<LoginApi>().getHandler())
      .add(di.get<NewsApi>().getHandler())
      .handler;

  //logRequest midleware ekleniyor
  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandlers);

  //Servisi çağır.
  CustomServer().initiliaze(
    handler: handler,
    address: Env.address,
    port: int.parse(Env.port),
  );
}
