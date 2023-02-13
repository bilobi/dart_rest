// ignore: file_names
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import 'package:backend/infrastructure/security/security_service.dart';
import 'package:shelf/shelf.dart';

import '../../utils/env/env.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  SecurityServiceImp() {
    print('Security Service Created ${DateTime.now().microsecondsSinceEpoch}');
  }
  @override
  String generateJWT(String userID) {
    var jwt = JWT({
      'iat': DateTime.now().microsecondsSinceEpoch,
      'userID': userID,
      'roles': ['admin', 'user']
    });
    // ignore: await_only_futures
    String key = Env.jwtkey;
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  JWT? validateJWT(String token) {
    String key = Env.jwtkey;
    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request request) {
        String? authorizatioHeader = request.headers["Authorization"];
        JWT? jwt;
        if (authorizatioHeader != null) {
          if (authorizatioHeader.startsWith("Bearer ")) {
            String token = authorizatioHeader.substring(7);
            jwt = validateJWT(token);
          }
        }
        var req = request.change(context: {'jwt': jwt});
        return handler(req);
      };
    };
  }

  @override
  Middleware get verfiyJwt =>
      createMiddleware(requestHandler: (Request request) {
        if (request.context['jwt'] == null) {
          return Response.forbidden("Not Authorized");
        }
        return null;
      });
}
