import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import 'data/repositories/products_impl_repository.dart';
import 'domain/usecases/create_product_impl_usecase.dart';
import 'domain/usecases/delete_product_impl_usecase.dart';
import 'domain/usecases/get_all_products_impl_usecase.dart';
import 'domain/usecases/get_product_by_id_impl_usecase.dart';
import 'external/databases/sqlite_database.dart';
import 'external/datasources/products_impl_datasource.dart';
import 'presentation/home/home_controller.dart';
import 'presentation/products/products_controller.dart';

class AppInitialize {
  AppInitialize() {
    init();
  }

  final router = Router();
  final getIt = GetIt.instance;

  void init() {
    initDependencies();
    initRoutes();
  }

  Router get() => router;

  void initDependencies() {
    var type = String.fromEnvironment('DB_TYPE');
    print("DB_TYPE: $type");

    // Utils
    if (type == "sqlite") {
      getIt.registerSingleton(SqliteDatabase());
    }

    // Datasources
    getIt.registerSingleton(
      ProductsImplDatasource(getIt<SqliteDatabase>()),
    );

    // Repositories
    getIt.registerSingleton(ProductsImplRepository(
      getIt<ProductsImplDatasource>(),
    ));

    // Usecases
    getIt.registerSingleton(
      GetAllProductsImplUsecase(getIt<ProductsImplRepository>()),
    );
    getIt.registerSingleton(
      GetProductByIdImplUsecase(getIt<ProductsImplRepository>()),
    );
    getIt.registerSingleton(
      CreateProductImplUsecase(getIt<ProductsImplRepository>()),
    );
    getIt.registerSingleton(
      DeleteProductImplUsecase(getIt<ProductsImplRepository>()),
    );

    // Controllers
    getIt.registerSingleton(HomeController());
    getIt.registerSingleton(ProductsController(
      getIt<GetAllProductsImplUsecase>(),
      getIt<GetProductByIdImplUsecase>(),
      getIt<CreateProductImplUsecase>(),
      getIt<DeleteProductImplUsecase>(),
    ));
  }

  void initRoutes() {
    // controllers
    final HomeController homeController = getIt();
    final ProductsController productsController = getIt();

    // routers
    router.get("/", homeController);
    router.get("/products", productsController.getAllProducts);
    router.get("/products/<id>", productsController.getproductById);
    router.post("/products", productsController.createProduct);
    router.delete("/products/<id>", productsController.deleteProduct);
  }
}
