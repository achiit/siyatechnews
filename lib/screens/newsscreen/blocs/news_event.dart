// lib/blocs/hacker_news_bloc/hacker_news_event.dart

import 'package:equatable/equatable.dart';

abstract class HackerNewsEvent extends Equatable {
  const HackerNewsEvent();

  @override
  List<Object> get props => [];
}

class FetchTopStories extends HackerNewsEvent {}

class LoadMoreStories extends HackerNewsEvent {}