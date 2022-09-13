import '../../domain/dtos/product_dto.dart';
import '../../domain/models/product_model.dart';

abstract class ProductsRepository {
  Future<List<ProductModel?>> findAllProducts();

  Future<ProductModel?> findProductById(int id);

  Future<ProductModel?> createProduct(ProductDto productDto);
}
