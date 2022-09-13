import '../../domain/dtos/product_dto.dart';
import '../../domain/models/product_model.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_datasource.dart';

class ProductsImplRepository implements ProductsRepository {
  ProductsImplRepository(this._datasource);

  final ProductsDatasource _datasource;

  @override
  Future<List<ProductModel>> findAllProducts() async {
    List<Map<String, dynamic>> data = await _datasource.findAllProducts();
    return data.map((map) => ProductModel.fromMap(map)).toList();
  }

  @override
  Future<ProductModel> findProductById(int id) async {
    Map<String, dynamic> data = await _datasource.findProductById(id);
    return ProductModel.fromMap(data);
  }

  @override
  Future<ProductModel> createProduct(ProductDto productDto) async {
    Map<String, dynamic> data = await _datasource.createProduct(productDto);
    return ProductModel.fromMap(data);
  }
}
