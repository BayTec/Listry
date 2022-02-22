import 'package:listry/database/abstract_database.dart';
import 'package:listry/entry/abstract_entry.dart';

class DatabaseEntry implements AbstractEntry {
  final int _id;
  final AbstractDatabase database;

  DatabaseEntry(this._id, this.database);

  @override
  Future<int> getAmount() async {
    final amounts =
        await database.query('SELECT amount FROM entry WHERE id = ${id()};');

    return amounts.first['amount'];
  }

  @override
  Future<bool> getChecked() async {
    final checks =
        await database.query('SELECT checked FROM entry WHERE id = ${id()};');

    return checks.first['checked'] > 0;
  }

  @override
  Future<String> getName() async {
    final names =
        await database.query('SELECT name FROM entry WHERE id = ${id()};');

    return names.first['name'];
  }

  @override
  int id() {
    return _id;
  }

  @override
  Future<void> setAmount(int amount) async {
    await database
        .execute('UPDATE entry SET amount = $amount WHERE id = ${id()};');
  }

  @override
  Future<void> setChecked(bool checked) async {
    await database
        .execute('UPDATE entry SET checked = $checked WHERE id = ${id()};');
  }

  @override
  Future<void> setName(String name) async {
    await database
        .execute('UPDATE entry SET name = ? WHERE id = ${id()};', [name]);
  }
}
