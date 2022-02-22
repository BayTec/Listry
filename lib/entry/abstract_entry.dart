abstract class AbstractEntry {
  int id();
  Future<int> getAmount();
  Future<void> setAmount(int amount);
  Future<String> getName();
  Future<void> setName(String name);
  Future<bool> getChecked();
  Future<void> setChecked(bool checked);
}
