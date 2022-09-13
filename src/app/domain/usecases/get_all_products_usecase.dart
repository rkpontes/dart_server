import '../models/product_model.dart';

abstract class GetAllProductsUsecase {
  Future<List<ProductModel>> call();
}
