import 'package:listry/database/abstract_database.dart';
import 'package:listry/listy/abstract_listy.dart';
import 'package:listry/listy/database_listy.dart';
import 'package:listry/listy_store/abstract_listy_store.dart';

class DatabaseListyStore implements AbstractListyStore {
  final AbstractDatabase database;

  DatabaseListyStore(this.database);

  @override
  Future<List<AbstractListy>> all() async {
    final List<AbstractListy> listies = [];

    final ids = await database.query('SELECT id FROM listy;');

    for (final element in ids) {
      listies.add(DatabaseListy(element['id'], database));
    }

    return listies;
  }

  @override
  Future<AbstractListy> create(String name) async {
    final ids = await database.query('SELECT id FROM listy;');

    var id = 0;
    while (ids.any((element) => element['id'] == id)) {
      id++;
    }

    await database
        .execute('INSERT INTO listy (id, name) VALUES ($id, ?);', [name]);

    return DatabaseListy(id, database);
  }

  @override
  Future<void> delete(AbstractListy listy) async {
    await database.execute('DELETE FROM listy WHERE id = ${listy.id()};');
  }

  @override
  Future<AbstractListy?> find(int id) async {
    final ids = await database.query('SELECT id FROM listy WHERE id = $id;');

    if (ids.isEmpty) {
      return null;
    }

    return DatabaseListy(ids.first['id'], database);
  }
}
