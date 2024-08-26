// lib/blocs/comments_bloc/comments_event.dart

import 'package:equatable/equatable.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class FetchComments extends CommentsEvent {
  final List<int> commentIds;

  const FetchComments(this.commentIds);

  @override
  List<Object> get props => [commentIds];
}