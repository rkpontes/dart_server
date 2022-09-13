import '../dtos/product_dto.dart';
import '../models/product_model.dart';

abstract class CreateProductUsecase {
  Future<ProductModel> call(ProductDto productDto);
}
