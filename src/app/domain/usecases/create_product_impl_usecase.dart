import '../dtos/product_dto.dart';
import '../models/product_model.dart';
import '../repositories/products_repository.dart';
import 'create_product_usecase.dart';

class CreateProductImplUsecase implements CreateProductUsecase {
  CreateProductImplUsecase(this._repository);

  final ProductsRepository _repository;

  @override
  Future<ProductModel?> call(ProductDto productDto) async {
    return await _repository.createProduct(productDto);
  }
}
