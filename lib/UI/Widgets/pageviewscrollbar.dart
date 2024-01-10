import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemsSchroolPage extends StatelessWidget {
  final List lists;
  final double height;
  final double borderRaduis;

  const ItemsSchroolPage({
    super.key,
    required this.lists,
    required this.height,
    required this.borderRaduis,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: PageView.builder(
        itemCount: lists.length,
        itemBuilder: (context, index) {
          return ItemsSchroolView(
            borderRaduis: borderRaduis,
            lists: lists,
            index: index,
          );
        },
      ),
    );
  }
}

class ItemsSchroolView extends StatelessWidget {
  const ItemsSchroolView({
    super.key,
    required this.borderRaduis,
    required this.lists,
    required this.index,
  });
  final int index;
  final double borderRaduis;
  final List lists;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRaduis),
      child: CachedNetworkImage(
        imageUrl: lists[index].imageUrl,
      ),
    );
  }
}

class ProductsItemsListView extends StatelessWidget {
  const ProductsItemsListView({
    super.key,
    required this.borderRaduis,
    required this.lists,
    required this.index,
  });
  final int index;
  final double borderRaduis;
  final List lists;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRaduis),
      child: CachedNetworkImage(
        imageUrl: lists[index].image,
      ),
    );
  }
}
