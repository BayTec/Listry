import 'package:listry/entry/abstract_entry.dart';

abstract class AbstractListy {
  int id();
  Future<String> getName();
  Future<void> setName(String name);
  Future<List<AbstractEntry>> getEntries();
  Future<AbstractEntry> createEntry(String name, int amount, bool checked);
  Future<void> deleteEntry(AbstractEntry entry);
}
