// lib/navigation/app_router.dart

import 'package:flutter/material.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/screens/commentscreen/comment_screen.dart';
import 'package:newsapp/screens/newsscreen/news_screen.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HackerNewsScreen());
      case '/comments':
        final HackerNewsItem item = settings.arguments as HackerNewsItem;
        return MaterialPageRoute(builder: (_) => CommentsScreen(item: item));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}