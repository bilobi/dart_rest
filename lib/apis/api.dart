import 'package:shelf/shelf.dart';

import '../infrastructure/dependecy_injectors/dependency_injector.dart';
import '../infrastructure/security/security_service_Imp.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = true});
  Handler createHandler({
    required Handler router,
    bool isSecurity = true,
    List<Middleware>? middlewares,
  }) {
    middlewares ??= [];
    if (isSecurity) {
      var securityService = DependencyInjector().get<SecurityServiceImp>();
      middlewares.addAll([
        securityService.authorization,
        securityService.verfiyJwt,
      ]);
    }
    var pipe = Pipeline();

    for (var m in middlewares) {
      pipe = pipe.addMiddleware(m);
    }

    return pipe.addHandler(router);
  }
}
