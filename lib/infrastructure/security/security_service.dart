import 'package:shelf/shelf.dart';

abstract class SecurityService<T> {
  String generateJWT(String userID);
  T? validateJWT(String token);

  Middleware get verfiyJwt;
  Middleware get authorization;
}
