// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

//@EnviedField(obfuscate: true)
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'ADDRESS')
  static const address = _Env.address;

  @EnviedField(varName: 'PORT')
  static const port = _Env.port;

  @EnviedField(varName: 'JWTKEY')
  static const jwtkey = _Env.jwtkey;
}
