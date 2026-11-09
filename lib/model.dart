
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> loadPosts() async {
  try {
    final response = await http
        .get(Uri.parse('https://chicken-tatsuta.github.io/journal-posts/posts.json'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    }
  } catch (_) {
    // Keep the bundled posts available when the feed cannot be reached.
  }
  return jsonDecode(await rootBundle.loadString('assets/posts.json'))
      as List<dynamic>;
}

class Task {
  String title;
  int status;
  int priority;

  Task(
    this.title, {
    this.status = 0,
    this.priority = 1,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'status': status,
    'priority': priority,
  };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['title'] as String,
      status: (json['status'] as num?)?.toInt() ?? 0,
      priority: (json['priority'] as num?)?.toInt() ?? 1,
    );
  }
}
