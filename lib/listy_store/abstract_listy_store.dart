import 'package:listry/listy/abstract_listy.dart';

abstract class AbstractListyStore {
  Future<List<AbstractListy>> all();
  Future<AbstractListy?> find(int id);
  Future<AbstractListy> create(String name);
  Future<void> delete(AbstractListy listy);
}
