import 'db_result.dart';

abstract class DBConnection {
  DBResult query(String sql, [List<String>? values]);
  List<Map<String, dynamic>> select(String sql, [List<String>? values]);
}
