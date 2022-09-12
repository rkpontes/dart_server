import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import '../src/controllers/products_controller.dart';
import '../src/services/products_services.dart';

final router = Router();

Response _helloWord(Request req) {
  return Response.ok("Hello World!");
}

void main(List<String> args) async {
  final productsController = ProductsController(ProductsService());

  router.get("/", _helloWord);
  router.get("/products", productsController.getAllProducts);
  router.get("/products/<id>", productsController.getproductById);
  router.post("/products", productsController.createproduct);

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
