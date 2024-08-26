// lib/blocs/hacker_news_bloc/hacker_news_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/screens/newsscreen/blocs/news_event.dart';
import 'package:newsapp/screens/newsscreen/blocs/news_state.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/services/new_service.dart';

class HackerNewsBloc extends Bloc<HackerNewsEvent, HackerNewsState> {
  final HackerNewsService _hackerNewsService;
  List<int> _storyIds = [];
  int _currentIndex = 0;
  static const int _itemsPerPage = 20;

  HackerNewsBloc(this._hackerNewsService) : super(HackerNewsInitial()) {
    on<FetchTopStories>(_onFetchTopStories);
    on<LoadMoreStories>(_onLoadMoreStories);
  }

  Future<void> _onFetchTopStories(
    FetchTopStories event,
    Emitter<HackerNewsState> emit,
  ) async {
    emit(HackerNewsLoading());
    try {
      _storyIds = await _hackerNewsService.getTopStories();
      final items = await _fetchItems();
      emit(HackerNewsLoaded(items: items, hasReachedMax: false));
    } catch (e) {
      emit(HackerNewsError(e.toString()));
    }
  }

  Future<void> _onLoadMoreStories(
    LoadMoreStories event,
    Emitter<HackerNewsState> emit,
  ) async {
    if (state is HackerNewsLoaded) {
      final currentState = state as HackerNewsLoaded;
      if (!currentState.hasReachedMax) {
        try {
          final newItems = await _fetchItems();
          emit(
            newItems.isEmpty
                ? currentState.copyWith(hasReachedMax: true)
                : HackerNewsLoaded(
                    items: currentState.items + newItems,
                    hasReachedMax: false,
                  ),
          );
        } catch (e) {
          emit(HackerNewsError(e.toString()));
        }
      }
    }
  }

  Future<List<HackerNewsItem>> _fetchItems() async {
    final itemsToFetch = _storyIds.skip(_currentIndex).take(_itemsPerPage);
    final items = await Future.wait(
      itemsToFetch.map((id) => _hackerNewsService.getItem(id)),
    );
    _currentIndex += _itemsPerPage;
    return items;
  }
}