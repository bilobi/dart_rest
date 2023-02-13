import 'dart:convert';

import 'package:backend/infrastructure/security/security_service_Imp.dart';
import 'package:backend/models/user_model/login_model.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'api.dart';

class LoginApi extends Api {
  final SecurityServiceImp _serviceImp;

  LoginApi(this._serviceImp);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.post('/login', (Request request) async {
      var body = await request.readAsString();
      LoginModel login = LoginModel.fromJson(jsonDecode(body));
      String token = _serviceImp.generateJWT(login.id.toString());
      var result = _serviceImp.validateJWT(token);
      // ignore: unnecessary_null_comparison
      if (result == null) {
        var loginbody = "{'message':'unauthorized','token':null}";
        return Response.unauthorized(loginbody);
      } else {
        var loginBody = "{'message': 'Api ok', 'token': '$token'})";
        return Response.ok(loginBody);
      }
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}
