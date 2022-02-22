import 'dart:convert';

import 'package:listry/entry/abstract_entry.dart';
import 'package:listry/entry/file_entry.dart';
import 'package:listry/file/abstract_file.dart';
import 'package:listry/listy/abstract_listy.dart';

class FileListy implements AbstractListy {
  final AbstractFile file;

  FileListy(this.file);

  Future<Map<String, dynamic>> json() async =>
      jsonDecode(await file.getContent());

  @override
  Future<String> getName() async {
    String name = '';

    var json = await this.json();
    if (json['name'] != null) {
      name = json['name'];
    }

    return name;
  }

  @override
  Future<void> setName(String name) async {
    var json = await this.json();
    json['name'] = name;
    await file.setContent(jsonEncode(json));
    await file.setName(name);
  }

  @override
  Future<List<AbstractEntry>> getEntries() async {
    List<AbstractEntry> entries = [];

    var json = await this.json();
    if (json['entries'] != null) {
      for (Map<String, dynamic> element in json['entries']) {
        entries.add(FileEntry(file, element['id']));
      }
    }

    return entries;
  }

  @override
  Future<AbstractEntry> createEntry(
      String name, int amount, bool checked) async {
    var json = await this.json();

    List<dynamic> entries = json['entries'];

    var id = 0;

    while (entries.any((element) => element['id'] == id)) {
      id++;
    }

    entries.add({
      'id': id,
      'name': name,
      'amount': amount,
      'checked': checked,
    });

    json['entries'] = entries;

    await file.setContent(jsonEncode(json));

    return FileEntry(file, id);
  }

  @override
  Future<void> deleteEntry(AbstractEntry entry) async {
    var json = await this.json();

    List<dynamic> entries = json['entries'];

    var index = entries.indexWhere((element) => element['id'] == entry.id());

    if (index >= 0) {
      entries.removeAt(index);
    }

    json['entries'] = entries;

    await file.setContent(jsonEncode(json));
  }

  @override
  int id() => int.tryParse(file.getName()) ?? -1;
}
