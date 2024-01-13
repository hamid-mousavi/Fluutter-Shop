import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/UI/Home/Home.dart';
import 'package:nike/UI/comment/bloc/comment_list_bloc.dart';
import 'package:nike/data/Model/Entity/Product.dart';
import 'package:nike/data/Model/Entity/comment.dart';
import 'package:nike/data/Repository/comment/Icomment_repository.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width - 100,
              flexibleSpace: ClipRRect(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: product.image,
                ),
              ),
              actions: [Icon(CupertinoIcons.heart)],
            ),
            SliverToBoxAdapter(
              child: Column(children: [
                Row(
                  children: [
                    Expanded(child: Text(product.title)),
                    Column(
                      children: [
                        Text(
                          product.previousPrice.toString(),
                        ),
                        Text(
                          product.price.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
                const Text(lorem),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('نظرات کاربران'),
                    TextButton(
                        onPressed: () {}, child: const Text('مشاهده همه'))
                  ],
                )
              ]),
            ),
            CommentList(productId: product.id),
          ],
        ),
      ),
    );
  }
}

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

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(comment.title),
              Text(comment.date),
            ],
          ),
          Text(comment.email),
          const SizedBox(height: 20),
          Text(comment.content),
        ],
      ),
    );
  }
}
