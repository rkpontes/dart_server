import '../../domain/dtos/product_dto.dart';

abstract class ProductsDatasource {
  Future<List<Map<String, dynamic>>?> findAllProducts();

  Future<Map<String, dynamic>?> findProductById(int id);

  Future<Map<String, dynamic>?> createProduct(ProductDto productDto);

  Future<bool?> deleteProduct(int id);
}
