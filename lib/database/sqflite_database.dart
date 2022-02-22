import 'package:listry/database/abstract_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase implements AbstractDatabase {
  Future<Database> database() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'listry.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db
            .execute('CREATE TABLE listy(id INTEGER PRIMARY KEY, name TEXT);');
        await db.execute(
            'CREATE TABLE entry(id INTEGER PRIMARY KEY, name TEXT, amount INTEGER, checked BOOLEAN, listy_id INTEGER);');
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> query(String sql,
      [List<Object>? parameter]) async {
    final connection = await database();

    return await connection.rawQuery(sql, parameter);
  }

  @override
  Future<void> execute(String sql, [List<Object>? parameter]) async {
    final connection = await database();

    await connection.execute(sql, parameter);
  }
}
