import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import 'data/repositories/products_impl_repository.dart';
import 'domain/usecases/create_product_impl_usecase.dart';
import 'domain/usecases/get_all_products_impl_usecase.dart';
import 'domain/usecases/get_product_by_id_impl_usecase.dart';
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
    // Datasources
    getIt.registerSingleton(ProductsImplDatasource());

    // Repositories
    getIt.registerSingleton(
      ProductsImplRepository(getIt<ProductsImplDatasource>()),
    );

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