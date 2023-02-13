import 'package:backend/apis/index.dart';
import 'package:backend/infrastructure/dependecy_injectors/dependency_injector.dart';

import '../../services/news_service.dart';
import '../security/security_service_Imp.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<SecurityServiceImp>(() => SecurityServiceImp());
    di.register<LoginApi>(() => LoginApi(di.get()));
    di.register<NewsService>(() => NewsService());
    di.register<NewsApi>(() => NewsApi(di.get()), isSingleton: false);

    return di;
  }
}
