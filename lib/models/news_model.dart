// lib/models/hacker_news_item.dart

class HackerNewsItem {
  final int id;
  final String title;
  final String? url;
  final String by;
  final int score;
  final int time;

  HackerNewsItem({
    required this.id,
    required this.title,
    this.url,
    required this.by,
    required this.score,
    required this.time,
  });

  factory HackerNewsItem.fromJson(Map<String, dynamic> json) {
    return HackerNewsItem(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      by: json['by'],
      score: json['score'],
      time: json['time'],
    );
  }
}