// lib/blocs/comments_bloc/comments_state.dart

import 'package:equatable/equatable.dart';
import 'package:newsapp/models/news_model.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();
  
  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {}

class CommentsLoading extends CommentsState {}

class CommentsLoaded extends CommentsState {
  final List<HackerNewsItem> comments;

  const CommentsLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentsError extends CommentsState {
  final String message;

  const CommentsError(this.message);

  @override
  List<Object> get props => [message];
}