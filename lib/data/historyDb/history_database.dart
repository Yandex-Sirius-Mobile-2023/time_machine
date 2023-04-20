abstract class HistoryDatabase {
  Future<List<Map<String, dynamic>>> getHistoryJson();
  Future<void> addHistoryJson(Map<String, Object?> json);
}
