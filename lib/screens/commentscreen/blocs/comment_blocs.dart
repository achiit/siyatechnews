// lib/blocs/comments_bloc/comments_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/screens/commentscreen/blocs/comment_event.dart';
import 'package:newsapp/screens/commentscreen/blocs/comment_state.dart';
import 'package:newsapp/services/new_service.dart';


class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final HackerNewsService _hackerNewsService;

  CommentsBloc(this._hackerNewsService) : super(CommentsInitial()) {
    on<FetchComments>(_onFetchComments);
  }

  Future<void> _onFetchComments(
    FetchComments event,
    Emitter<CommentsState> emit,
  ) async {
    emit(CommentsLoading());
    try {
      final comments = await Future.wait(
        event.commentIds.map((id) => _hackerNewsService.getItem(id)),
      );
      emit(CommentsLoaded(comments));
    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }
}