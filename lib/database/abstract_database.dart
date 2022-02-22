abstract class AbstractDatabase {
  Future<List<Map<String, dynamic>>> query(String sql,
      [List<Object>? parameter]);
  Future<void> execute(String sql, [List<Object>? parameter]);
}
