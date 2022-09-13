import '../../data/datasources/products_datasource.dart';
import '../../domain/dtos/product_dto.dart';
import '../../domain/models/product_model.dart';
import '../mocks/products_data.dart';

class ProductsImplDatasource implements ProductsDatasource {
  @override
  Future<List<Map<String, dynamic>>> findAllProducts() async {
    await Future.delayed(Duration(milliseconds: 50));
    return products;
  }

  @override
  Future<Map<String, dynamic>> findProductById(int id) async {
    await Future.delayed(Duration(milliseconds: 50));
    return products.firstWhere((product) => product["id"] == id);
  }

  @override
  Future<Map<String, dynamic>> createProduct(ProductDto productDto) async {
    await Future.delayed(Duration(milliseconds: 50));

    List<ProductModel> productsSortable =
        products.map((product) => ProductModel.fromMap(product)).toList();

    productsSortable.sort((a, b) => a.id.compareTo(b.id));

    productDto = productDto.copyWith(id: productsSortable.last.id + 1);
    Map<String, dynamic> newProductMap = productDto.toMap();
    products.add(newProductMap);
    return newProductMap;
  }
}
