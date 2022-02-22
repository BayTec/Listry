import 'dart:io';

import 'package:listry/file/abstract_file.dart';
import 'package:listry/file/io_file.dart';
import 'package:listry/file_store/abstract_file_store.dart';
import 'package:path/path.dart';

class IoFileStore implements AbstractFileStore {
  final Directory directory;

  IoFileStore(this.directory);

  @override
  Future<List<AbstractFile>> all() async {
    List<AbstractFile> files = [];

    var fileSystemEntities = directory.list();

    await for (var element in fileSystemEntities) {
      if (element.uri.scheme.isNotEmpty) {
        files.add(IoFile(File(element.path)));
      }
    }

    return files;
  }

  @override
  Future<AbstractFile> create(String name) async {
    var file = File(join(directory.path, name));

    if (!await file.exists()) {
      await file.create();
    }

    return IoFile(file);
  }

  @override
  Future<void> delete(AbstractFile file) async {
    var _file = File(join(directory.path, file.getName()));

    if (await _file.exists()) {
      await _file.delete();
    }
  }

  @override
  Future<AbstractFile?> find(String name) async {
    var file = File(join(directory.path, name));

    if (!await file.exists()) {
      return null;
    }

    return IoFile(file);
  }
}
