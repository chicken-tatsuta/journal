
import 'package:flutter/material.dart';
import 'controller.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  var controller = JournalController();
  String keyword = '';

  // いいねした投稿を記録
  final Set<String> likedPosts = {};

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await controller.load();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('つぶやき表示'),
    ),
    body: Column(
      children: [
        // 検索欄
        TextField(
          decoration: const InputDecoration(
            hintText: '検索',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (s) => setState(() => keyword = s),
        ),

        // 投稿一覧
        Expanded(
          child: ListView(
            children: [
              for (var p in controller.search(keyword))
                Builder(
                  builder: (context) {
                    final id = '${p['user']}_${p['text']}';
                    final isLiked = likedPosts.contains(id);

                    return ListTile(
                      leading: Text(
                        p['emoji'] ?? '',
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(p['user'] ?? ''),
                      subtitle: Text(p['text'] ?? ''),

                      // いいねボタン
                      trailing: IconButton(
                        icon: Icon(
                          isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isLiked) {
                              likedPosts.remove(id);
                            } else {
                              likedPosts.add(id);
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
