import 'package:flutter/material.dart';
import 'package:lingopanda_xh/providers/comments_provider.dart';
import 'package:provider/provider.dart';
import 'package:lingopanda_xh/constants/colors_constants.dart';
import 'package:lingopanda_xh/constants/string_constants.dart';
import 'package:lingopanda_xh/constants/text_styles_constants.dart';
import 'package:lingopanda_xh/widgets/comment_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommentsProvider()..fetchComments(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstants.comments,
            style: PoppinsTextStyle.bold(color: AppColors.bgWhite),
          ),
        ),
        body: Consumer<CommentsProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.errorMessage != null) {
              return Center(
                child: Text(provider.errorMessage!),
              );
            } else if (provider.comments.isEmpty) {
              return const Center(
                child: Text('No comments available'),
              );
            } else {
              return ListView.builder(
                itemCount: provider.comments.length,
                itemBuilder: (context, index) {
                  final comment = provider.comments[index];
                  return CommentCard(
                    name: comment.name,
                    comment: comment.body,
                    email: comment.email,
                    isEmailFull: provider.isEmailFull,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
