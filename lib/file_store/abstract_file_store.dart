import 'package:listry/file/abstract_file.dart';

abstract class AbstractFileStore {
  Future<List<AbstractFile>> all();
  Future<AbstractFile> create(String name);
  Future<AbstractFile?> find(String name);
  Future<void> delete(AbstractFile file);
}
