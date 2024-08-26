// lib/blocs/hacker_news_bloc/hacker_news_state.dart

import 'package:equatable/equatable.dart';
import 'package:newsapp/models/news_model.dart';

abstract class HackerNewsState extends Equatable {
  const HackerNewsState();
  
  @override
  List<Object> get props => [];
}

class HackerNewsInitial extends HackerNewsState {}

class HackerNewsLoading extends HackerNewsState {}

class HackerNewsLoaded extends HackerNewsState {
  final List<HackerNewsItem> items;
  final bool hasReachedMax;

  const HackerNewsLoaded({
    required this.items,
    this.hasReachedMax = false,
  });

  HackerNewsLoaded copyWith({
    List<HackerNewsItem>? items,
    bool? hasReachedMax,
  }) {
    return HackerNewsLoaded(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax];
}

class HackerNewsError extends HackerNewsState {
  final String message;

  const HackerNewsError(this.message);

  @override
  List<Object> get props => [message];
}