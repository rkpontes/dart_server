import 'package:args/args.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import 'app_environment.dart';
import 'data/repositories/products_impl_repository.dart';
import 'domain/usecases/create_product_impl_usecase.dart';
import 'domain/usecases/get_all_products_impl_usecase.dart';
import 'domain/usecases/get_product_by_id_impl_usecase.dart';
import 'external/databases/sqlite_database.dart';
import 'external/datasources/products_impl_datasource.dart';
import 'presentation/home/home_controller.dart';
import 'presentation/products/products_controller.dart';

class AppInitialize {
  AppInitialize(this.params) {
    init();
  }

  final router = Router();
  final getIt = GetIt.instance;
  final Map<String, dynamic>? params;

  void init() {
    initDependencies();
    initRoutes();
  }

  Router get() => router;

  String changePathEnv() {
    var key = params?["mode"];

    var path = "";
    switch (key) {
      case "dev":
        path = ".debug-env";
        break;
      case "prod":
        path = ".env";
        break;
      default:
        path = ".debug-env";
        break;
    }

    return path;
  }

  void initDependencies() {
    var env = AppEnv(changePathEnv());
    // Utils
    getIt.registerSingleton(env);
    if (env["DB_TYPE"] == "sqlite") {
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

    // Controllers
    getIt.registerSingleton(HomeController());
    getIt.registerSingleton(ProductsController(
      getIt<GetAllProductsImplUsecase>(),
      getIt<GetProductByIdImplUsecase>(),
      getIt<CreateProductImplUsecase>(),
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
  }
}
