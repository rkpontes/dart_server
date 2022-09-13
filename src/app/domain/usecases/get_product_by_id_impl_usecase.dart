import '../models/product_model.dart';
import '../repositories/products_repository.dart';
import 'get_product_by_id_usecase.dart';

class GetProductByIdImplUsecase implements GetProductByIdUsecase {
  GetProductByIdImplUsecase(this._repository);

  final ProductsRepository _repository;

  @override
  Future<ProductModel?> call(int id) async {
    return await _repository.findProductById(id);
  }
}
