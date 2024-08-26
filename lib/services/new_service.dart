// lib/services/hacker_news_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/news_model.dart';

class HackerNewsService {
  static const String _baseUrl = 'https://hacker-news.firebaseio.com/v0';

  Future<List<int>> getTopStories() async {
    final response = await http.get(Uri.parse('$_baseUrl/topstories.json'));
    if (response.statusCode == 200) {
      return List<int>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load top stories');
    }
  }

  Future<HackerNewsItem> getItem(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/item/$id.json'));
    if (response.statusCode == 200) {
      return HackerNewsItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load item');
    }
  }
}