import '../models/product_model.dart';

abstract class GetProductByIdUsecase {
  Future<ProductModel?> call(int id);
}
