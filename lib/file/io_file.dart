import 'dart:io';

import 'package:listry/file/abstract_file.dart';

class IoFile implements AbstractFile {
  File file;

  IoFile(this.file);

  @override
  Future<String> getContent() async {
    return await file.readAsString();
  }

  @override
  String getName() {
    return file.path.split('/').last;
  }

  @override
  Future<void> setContent(String content) async {
    await file.writeAsString(content);
  }

  @override
  Future<void> setName(String name) async {
    var splitPath = file.path.split('/');
    splitPath.last = name;
    var path = splitPath.join('/');

    file = await file.rename(path);
  }
}
