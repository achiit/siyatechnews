// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/blocs/news_bloc.dart';
import 'package:newsapp/screens/news_screen.dart';
import 'package:newsapp/services/new_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => HackerNewsBloc(HackerNewsService()),
        child: HackerNewsScreen(),
      ),
    );
  }
}