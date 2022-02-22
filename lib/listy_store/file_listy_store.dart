import 'package:listry/file_store/abstract_file_store.dart';
import 'package:listry/listy/abstract_listy.dart';
import 'package:listry/listy/file_listy.dart';
import 'package:listry/listy_store/abstract_listy_store.dart';

class FileListyStore implements AbstractListyStore {
  final AbstractFileStore fileStore;

  FileListyStore(this.fileStore);

  Future<int> generateId() async {
    var lists = await all();

    int id = 0;

    while (lists.any((element) => element.id() == id)) {
      id++;
    }

    return id;
  }

  @override
  Future<List<AbstractListy>> all() async {
    List<AbstractListy> lists = [];

    var files = await fileStore.all();

    for (var element in files) {
      lists.add(FileListy(element));
    }

    return lists;
  }

  @override
  Future<AbstractListy> create(String name) async {
    var id = await generateId();

    var file = await fileStore.create(id.toString());

    await file.setContent('{"id": $id, "name": "$name", "entries": []}');

    return FileListy(file);
  }

  @override
  Future<void> delete(AbstractListy listy) async {
    var file = await fileStore.find(listy.id().toString());
    if (file != null) {
      await fileStore.delete(file);
    }
  }

  @override
  Future<AbstractListy?> find(int id) async {
    var file = await fileStore.find(id.toString());

    if (file == null) {
      return null;
    }

    return FileListy(file);
  }
}
