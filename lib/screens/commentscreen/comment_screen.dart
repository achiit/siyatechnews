// lib/screens/comments_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/screens/commentscreen/blocs/comment_blocs.dart';
import 'package:newsapp/screens/commentscreen/blocs/comment_event.dart';
import 'package:newsapp/screens/commentscreen/blocs/comment_state.dart';
import 'package:newsapp/services/new_service.dart';
import 'package:newsapp/theme/app_colors.dart';

class CommentsScreen extends StatelessWidget {
  final HackerNewsItem item;

  const CommentsScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentsBloc(HackerNewsService())
        ..add(FetchComments(item.kids ?? [])),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          leadingWidth: MediaQuery.of(context).size.width * 0.3,
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: SvgPicture.asset('assets/images/siyalogo.svg'),
          ),
          title: Text('Comments', style: TextStyle(color: Colors.black)),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItemHeader(context),
            Expanded(
              child: BlocBuilder<CommentsBloc, CommentsState>(
                builder: (context, state) {
                  if (state is CommentsLoading) {
                    return _buildLoadingIndicator();
                  } else if (state is CommentsLoaded) {
                    return state.comments.isEmpty
                        ? _buildNoCommentsWidget()
                        : _buildCommentsList(state.comments);
                  } else if (state is CommentsError) {
                    return _buildErrorWidget(state.message);
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemHeader(BuildContext context) {
    return Card(
      color: AppColors.backgroundColor,
      surfaceTintColor: Colors.white,
      margin: EdgeInsets.all(8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.content,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: AppColors.textPrimaryColor,
                  ),
            ),
            SizedBox(height: 8),
            Text(
              'by ${item.by ?? 'Unknown'} | ${item.score ?? 0} points',
              style: TextStyle(color: AppColors.textSecondaryColor),
            ),
          ],
        ),
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

  Widget _buildNoCommentsWidget() {
    return Center(
      child: Text(
        'No comments found',
        style: TextStyle(color: AppColors.textPrimaryColor),
      ),
    );
  }

  Widget _buildCommentsList(List<HackerNewsItem> comments) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return _buildCommentItem(context, comments[index], index);
      },
    );
  }

  Widget _buildCommentItem(
      BuildContext context, HackerNewsItem comment, int index) {
    if (!comment.hasContent) {
      return SizedBox.shrink();
    }
    return Card(
      color: AppColors.backgroundColor,
      surfaceTintColor: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getColorForIndex(index),
                  child: Text(
                    comment.by?[0].toUpperCase() ?? '?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'by ${comment.by ?? 'Unknown'}',
                  style: TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              comment.content,
              style: TextStyle(color: AppColors.textPrimaryColor),
            ),
            if (comment.kids != null && comment.kids!.isNotEmpty)
              TextButton(
                child: Text('View ${comment.kids!.length} replies'),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/comments',
                    arguments: comment,
                  );
                },
              ),
          ],
        ),
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
