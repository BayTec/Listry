import 'package:listry/database/abstract_database.dart';
import 'package:listry/entry/abstract_entry.dart';
import 'package:listry/entry/database_entry.dart';
import 'package:listry/listy/abstract_listy.dart';

class DatabaseListy implements AbstractListy {
  final int _id;
  final AbstractDatabase database;

  DatabaseListy(this._id, this.database);

  @override
  Future<AbstractEntry> createEntry(
      String name, int amount, bool checked) async {
    final ids = await database.query('SELECT id FROM entry;');

    var id = 0;
    while (ids.any((element) => element['id'] == id)) {
      id++;
    }

    await database.execute(
        'INSERT INTO entry (id, name, amount, checked, listy_id) VALUES ($id, ?, $amount, $checked, ${this.id()});',
        [name]);

    return DatabaseEntry(id, database);
  }

  @override
  Future<List<AbstractEntry>> getEntries() async {
    final List<AbstractEntry> entries = [];

    final ids =
        await database.query('SELECT id FROM entry WHERE listy_id = ${id()};');

    for (final element in ids) {
      entries.add(DatabaseEntry(element['id'], database));
    }

    return entries;
  }

  @override
  Future<String> getName() async {
    final names =
        await database.query('SELECT name FROM listy WHERE id = ${id()};');

    return names.first['name'];
  }

  @override
  int id() {
    return _id;
  }

  @override
  Future<void> deleteEntry(AbstractEntry entry) async {
    await database.execute('DELETE FROM entry WHERE id = ${entry.id()};');
  }

  @override
  Future<void> setName(String name) async {
    await database
        .execute('UPDATE listy SET name = ? WHERE id = ${id()};', [name]);
  }
}
