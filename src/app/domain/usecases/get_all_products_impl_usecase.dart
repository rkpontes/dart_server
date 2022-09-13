import '../models/product_model.dart';
import '../repositories/products_repository.dart';
import 'get_all_products_usecase.dart';

class GetAllProductsImplUsecase implements GetAllProductsUsecase {
  GetAllProductsImplUsecase(this._repository);

  final ProductsRepository _repository;

  @override
  Future<List<ProductModel?>> call() async {
    return await _repository.findAllProducts();
  }
}
