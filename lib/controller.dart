import 'model.dart';

class JournalController {
  List posts = [];

  Future<void> load() async {
    posts = await loadPosts();
  }

  List search(String keyword) {
    List result = [];
    for (var p in posts) {
      if (p['user'].contains(keyword) || p['text'].contains(keyword)) {
        result.add(p);
      }
    }
    return result;
  }
}