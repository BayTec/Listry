import 'dart:convert';

import 'package:listry/entry/abstract_entry.dart';
import 'package:listry/file/abstract_file.dart';

class FileEntry implements AbstractEntry {
  final AbstractFile file;
  final int _id;

  FileEntry(this.file, this._id);

  Future<Map<String, dynamic>> getList() async =>
      jsonDecode(await file.getContent());

  Future<List<dynamic>> getEntries() async => (await getList())['entries'];

  Future<Map<String, dynamic>> getEntryMap() async =>
      (await getEntries()).firstWhere((element) => element['id'] == _id);

  @override
  Future<int> getAmount() async {
    return (await getEntryMap())['amount'];
  }

  @override
  Future<bool> getChecked() async {
    return (await getEntryMap())['checked'];
  }

  @override
  Future<String> getName() async {
    return (await getEntryMap())['name'];
  }

  @override
  Future<void> setAmount(int amount) async {
    var list = await getList();
    var entries = await getEntries();
    int index = entries.indexWhere((element) => element['id'] == _id);
    entries[index]['amount'] = amount;
    list['entries'] = entries;
    await file.setContent(jsonEncode(list));
  }

  @override
  Future<void> setChecked(bool checked) async {
    var list = await getList();
    var entries = await getEntries();
    int index = entries.indexWhere((element) => element['id'] == _id);
    entries[index]['checked'] = checked;
    list['entries'] = entries;
    await file.setContent(jsonEncode(list));
  }

  @override
  Future<void> setName(String name) async {
    var list = await getList();
    var entries = await getEntries();
    int index = entries.indexWhere((element) => element['id'] == _id);
    entries[index]['name'] = name;
    list['entries'] = entries;
    await file.setContent(jsonEncode(list));
  }

  @override
  int id() => _id;
}
