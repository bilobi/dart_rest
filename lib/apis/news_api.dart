import 'dart:convert';

import 'package:backend/models/news_model/news_model.dart';
import 'package:backend/services/news_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'api.dart';

class NewsApi extends Api {
  final NewsService _service;

  NewsApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = true}) {
    Router router = Router();

    ///**
    /// GET
    /// */
    router.get('/blog/<blogId|[0-9]+>', (Request request, String blogId) {
      var result = _service.findOne(int.parse(blogId));

      if (result == null) {
        return Response.ok(
          "",
          //headers: {'Content-Type': 'application/json'},
        );
      } else {
        var response = result.toString();
        print(response);
        return Response.ok(
          response,
          //headers: {'Content-Type': 'application/json'},
        );
      }
    });

    ///**
    /// GET ALL
    /// */
    router.get('/blog', (Request request) async {
      var result = _service.findMany();

      var response = result.toString();
      return Response.ok(
        response,
        //headers: {'Content-Type': 'application/json'},
      );
    });

    ///**
    /// POST
    /// */
    router.post('/blog', (Request request) async {
      var body = await request.readAsString();

      NewsModel model = NewsModel.fromJson(jsonDecode(body));
      bool response = await _service.save(model);
      if (response) {
        return Response.ok(
          model.toString(),
          //headers: {'Content-Type': 'application/json'},
        );
      }
      return Response.badRequest();
    });

    ///**
    /// PUT
    /// */
    router.put('/blog/<blogId|[0-9]+>', (Request request, String blogId) async {
      Map<String, dynamic> body = jsonDecode(await request.readAsString());
      body.remove("id");
      var newModel = NewsModel.fromJson(body);

      bool response = await _service.save(newModel);
      newModel.id = int.parse(blogId);
      if (response) {
        return Response(
          201,
          body: newModel.toString(),
          //headers: {'Content-Type': 'application/json'},
        );
      }
      return Response.badRequest();
    });

    ///**
    /// DELETE
    /// */
    router.delete('/blog/<blogId|[0-9]+>', (Request request, String blogId) {
      bool result = _service.delete(int.parse(blogId));
      return Response.ok('Blog deleted');
    });

    return createHandler(
        router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
