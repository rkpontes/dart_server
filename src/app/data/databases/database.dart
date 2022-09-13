import 'db_result.dart';

abstract class DB {
  DBResult query(String sql, [List<String>? values]);
  List<Map<String, dynamic>> select(String sql, [List<String>? values]);
}
