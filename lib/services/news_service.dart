import 'package:backend/services/iservice.dart';

import '../models/index.dart';
import '../utils/extension/list_extension.dart';

class NewsService implements IService<NewsModel> {
  List<NewsModel> _mockDB = [];

  @override
  bool delete(int id) {
    var data = _mockDB.firstWhereOrNull((e) => e.id == id);

    _mockDB.remove(data);
    return true;
  }

  @override
  List<NewsModel> findMany() {
    return _mockDB;
  }

  @override
  NewsModel? findOne(int id) {
    if (_mockDB.isNotEmpty) {
      return _mockDB.firstWhereOrNull((e) => e.id == id);
    } else {
      return null;
    }
  }

  @override
  bool save(NewsModel model) {
    NewsModel? data = _mockDB.firstWhereOrNull((e) => e.id == model.id);
    if (data == null) {
      _mockDB.add(model);
    } else {
      var index = _mockDB.indexOf(model);
      _mockDB[index] = model;
    }
    return true;
  }
}
