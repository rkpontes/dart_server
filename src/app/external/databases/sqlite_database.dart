import 'package:sqlite3/sqlite3.dart';

import '../../data/databases/db_connection.dart';
import '../../data/databases/db_result.dart';

class SqliteDatabase implements DBConnection {
  SqliteDatabase() {
    var path = String.fromEnvironment('DB_PATH');
    print("DB_PATH: $path");

    db = sqlite3.open(path);
  }
  var db;

  @override
  DBResult query(String sql, [List<String>? values]) {
    print(sql);
    try {
      final stmt = db.prepare(sql);
      stmt.execute(values ?? []);

      return DBResult(rows: [
        {"message": "DB: ${values?.length ?? 0} rows affected."}
      ]);
    } catch (e) {
      rethrow;
    }
  }

  String getTableName(String sql) {
    var split = sql.split(" ");
    switch (split.first.toLowerCase()) {
      case "insert":
        return split[2];
      case "update":
        return split[1];
      case "delete":
        return split[2];
      default:
        throw "ERROR";
    }
  }

  @override
  List<Map<String, dynamic>> select(String sql, [List<String>? values]) {
    try {
      final ResultSet resultSet = db.select(sql, values ?? []);
      List<Map<String, dynamic>> rows = <Map<String, dynamic>>[];

      for (int i = 0; i < resultSet.length; i++) {
        final Row row = resultSet[i];
        Map<String, dynamic> map = {};
        int j = 0;
        for (var column in row.keys) {
          map[column] = row[j];
          j++;
        }
        rows.add(map);
      }

      return rows;
    } catch (e) {
      rethrow;
    }
  }
}
