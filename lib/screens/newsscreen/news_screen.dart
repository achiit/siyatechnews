// lib/screens/hacker_news_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/screens/newsscreen/blocs/news_bloc.dart';
import 'package:newsapp/screens/newsscreen/blocs/news_event.dart';
import 'package:newsapp/screens/newsscreen/blocs/news_state.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/theme/app_colors.dart';

class HackerNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * 0.3,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: SvgPicture.asset('assets/images/siyalogo.svg'),
        ),
        title: Text('Hacker News', style: TextStyle(color: Colors.black)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: BlocBuilder<HackerNewsBloc, HackerNewsState>(
        builder: (context, state) {
          if (state is HackerNewsInitial) {
            BlocProvider.of<HackerNewsBloc>(context).add(FetchTopStories());
            return _buildLoadingIndicator();
          } else if (state is HackerNewsLoading) {
            return _buildLoadingIndicator();
          } else if (state is HackerNewsLoaded) {
            return _buildList(context, state);
          } else if (state is HackerNewsError) {
            return _buildErrorWidget(state.message);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
      ),
    );
  }

  Widget _buildList(BuildContext context, HackerNewsLoaded state) {
    if (state.items.isEmpty) {
      return Center(
          child: Text('No news found',
              style: TextStyle(color: AppColors.textPrimaryColor)));
    }
    return ListView.builder(
      itemCount: state.items.length + 1,
      itemBuilder: (context, index) {
        if (index >= state.items.length) {
          if (!state.hasReachedMax) {
            BlocProvider.of<HackerNewsBloc>(context).add(LoadMoreStories());
            return _buildLoadingIndicator();
          } else {
            return SizedBox.shrink();
          }
        }
        return _buildListItem(context, state.items[index], index);
      },
    );
  }

  Widget _buildListItem(BuildContext context, HackerNewsItem item, int index) {
    if (!item.hasContent) {
      return SizedBox.shrink();
    }
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        tileColor: AppColors.backgroundColor.withOpacity(0.9),
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: _getColorForIndex(index),
          child: Text(
            '${index + 1}',
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          item.content,
          style: TextStyle(
            color: AppColors.textPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'by ${item.by ?? 'Unknown'} | ${item.score ?? 0} points',
            style: TextStyle(color: AppColors.textSecondaryColor),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/comments',
            arguments: item,
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }

  Color _getColorForIndex(int index) {
    final colors = [
      AppColors.accentColor1,
      AppColors.accentColor2,
      AppColors.accentColor3
    ];
    return colors[index % colors.length];
  }
}
