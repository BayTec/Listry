abstract class AbstractFile {
  String getName();
  Future<void> setName(String name);
  Future<String> getContent();
  Future<void> setContent(String content);
}
