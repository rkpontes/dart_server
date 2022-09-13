import '../../data/datasources/products_datasource.dart';
import '../../domain/dtos/product_dto.dart';
import '../databases/sqlite_database.dart';

class ProductsImplDatasource implements ProductsDatasource {
  final db = SqliteDatabase();

  @override
  Future<List<Map<String, dynamic>>?> findAllProducts() async {
    await Future.delayed(Duration(milliseconds: 50));
    try {
      return db.select('SELECT * FROM products');
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> findProductById(int id) async {
    await Future.delayed(Duration(milliseconds: 50));
    try {
      var res =
          db.select('SELECT * FROM products WHERE id = ?', [id.toString()]);
      if (res.isNotEmpty) {
        return res.first;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> createProduct(ProductDto productDto) async {
    await Future.delayed(Duration(milliseconds: 50));

    try {
      db.query('INSERT INTO products (name, tags) VALUES (? , ?)', [
        productDto.name ?? '',
        productDto.tags?.join(',') ?? '',
      ]);

      var res = db.select("SELECT * FROM products");

      if (res.isNotEmpty) {
        return res.last;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
