import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import '../src/app/data/repositories/products_impl_repository.dart';
import '../src/app/domain/usecases/create_product_impl_usecase.dart';
import '../src/app/domain/usecases/get_all_products_impl_usecase.dart';
import '../src/app/domain/usecases/get_product_by_id_impl_usecase.dart';
import '../src/app/external/datasources/products_impl_datasource.dart';
import '../src/app/presentation/home/home_controller.dart';
import '../src/app/presentation/products/products_controller.dart';

final router = Router();

void main(List<String> args) async {
  // TODO: inserir injeção de dependencias
  final productsImplDatasource = ProductsImplDatasource();
  final productsImplRepository = ProductsImplRepository(productsImplDatasource);
  final productsController = ProductsController(
    GetAllProductsImplUsecase(productsImplRepository),
    GetProductByIdImplUsecase(productsImplRepository),
    CreateProductImplUsecase(productsImplRepository),
  );

  router.get("/", HomeController());
  router.get("/products", productsController.getAllProducts);
  router.get("/products/<id>", productsController.getproductById);
  router.post("/products", productsController.createProduct);

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
