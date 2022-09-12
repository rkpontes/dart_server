import '../data/products_data.dart';
import '../dto/product_dto.dart';
import '../models/product_model.dart';

class ProductsService {
  Future<List<ProductModel>> findAllProducts() async {
    await Future.delayed(Duration(milliseconds: 50));
    return products.map((product) => ProductModel.fromMap(product)).toList();
  }

  Future<ProductModel> findProductById(int id) async {
    await Future.delayed(Duration(milliseconds: 50));
    return ProductModel.fromMap(
      products.firstWhere((product) => product["id"] == id),
    );
  }

  Future<ProductModel> createProduct(ProductDto productDto) async {
    await Future.delayed(Duration(milliseconds: 50));

    List<ProductModel> productsSortable =
        products.map((product) => ProductModel.fromMap(product)).toList();

    productsSortable.sort((a, b) => a.id.compareTo(b.id));

    productDto = productDto.copyWith(id: productsSortable.last.id + 1);
    Map<String, dynamic> newProductMap = productDto.toMap();
    products.add(newProductMap);
    return ProductModel.fromMap(newProductMap);
  }
}
