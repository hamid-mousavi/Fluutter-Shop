import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/UI/Detail/bloc/product_detail_bloc.dart';
import 'package:nike/UI/Home/Home.dart';
import 'package:nike/data/Model/Entity/Product.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';
import 'package:nike/data/Repository/cart/cart_repository.dart';

import '../comment/comment_list.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = ProductDetailBloc(cartRepository);
        bloc.stream.forEach((state) {
          if (state is AddtoCartSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Sucsess')));
          } else if (state is AddToCartError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Error')));
          }
        });
        return bloc;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            return FloatingActionButton.extended(
                onPressed: () {
                  AuthRepository.authChangeNotifier.value != null &&
                          AuthRepository
                              .authChangeNotifier.value!.accessTocken.isNotEmpty
                      ? BlocProvider.of<ProductDetailBloc>(context)
                          .add(AddToCartButtnClicked(productId: product.id))
                      : ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('لطفا ابتدا وارد شوید')));
                },
                label: SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: const Center(child: Text('افزودن به سبد خرید'))));
          },
        ),
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
