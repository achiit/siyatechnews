// lib/models/hacker_news_item.dart

class HackerNewsItem {
  final int id;
  final String? title;
  final String? text;
  final String? url;
  final String? by;
  final int? score;
  final int? time;
  final List<int>? kids;

  HackerNewsItem({
    required this.id,
    this.title,
    this.text,
    this.url,
    this.by,
    this.score,
    this.time,
    this.kids,
  });

  factory HackerNewsItem.fromJson(Map<String, dynamic> json) {
    return HackerNewsItem(
      id: json['id'] ?? 0,
      title: json['title'],
      text: json['text'],
      url: json['url'],
      by: json['by'],
      score: json['score'],
      time: json['time'],
      kids: json['kids'] != null ? List<int>.from(json['kids']) : null,
    );
  }

  String get content => title ?? text ?? 'No content available';
  bool get hasContent => title != null || text != null;
}