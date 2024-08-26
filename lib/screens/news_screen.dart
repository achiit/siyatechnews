// lib/screens/hacker_news_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/blocs/news_bloc.dart';
import 'package:newsapp/blocs/news_event.dart';
import 'package:newsapp/blocs/news_state.dart';
import 'package:newsapp/models/news_model.dart';


class HackerNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hacker News')),
      body: BlocBuilder<HackerNewsBloc, HackerNewsState>(
        builder: (context, state) {
          if (state is HackerNewsInitial) {
            BlocProvider.of<HackerNewsBloc>(context).add(FetchTopStories());
            return Center(child: CircularProgressIndicator());
          } else if (state is HackerNewsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HackerNewsLoaded) {
            return _buildList(context, state);
          } else if (state is HackerNewsError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, HackerNewsLoaded state) {
    return ListView.builder(
      itemCount: state.items.length + 1,
      itemBuilder: (context, index) {
        if (index >= state.items.length) {
          if (!state.hasReachedMax) {
            BlocProvider.of<HackerNewsBloc>(context).add(LoadMoreStories());
            return Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        }
        return _buildListItem(state.items[index]);
      },
    );
  }

  Widget _buildListItem(HackerNewsItem item) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text('by ${item.by} | ${item.score} points'),
      onTap: () {
        // TODO: Implement item tap action (e.g., open URL)
      },
    );
  }
}