import '../repositories/products_repository.dart';
import 'delete_product_usecase.dart';

class DeleteProductImplUsecase implements DeleteProductUsecase {
  DeleteProductImplUsecase(this._repository);

  final ProductsRepository _repository;

  @override
  Future<bool> call(int id) async {
    return await _repository.deleteProduct(id);
  }
}
