import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/UI/comment/bloc/comment_list_bloc.dart';
import 'package:nike/data/Repository/comment/Icomment_repository.dart';

import 'comment_item.dart';

class CommentList extends StatelessWidget {
  final int productId;

  const CommentList({super.key, required this.productId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = CommentListBloc(commentListRepository, productId);
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListSuccess) {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return CommentItem(
                  comment: state.comments[index],
                );
              }, childCount: state.comments.length),
            );
          } else if (state is CommentListLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CommentListErr) {
            return const SliverToBoxAdapter(
              child: Text('Error'),
            );
          } else {
            return const SliverToBoxAdapter(
              child: Text('State is not valid'),
            );
          }
        },
      ),
    );
  }
}
