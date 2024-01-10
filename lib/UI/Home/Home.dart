import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/UI/Home/bloc/home_bloc.dart';
import 'package:nike/UI/Widgets/pageviewscrollbar.dart';
import 'package:nike/data/Model/Entity/Product.dart';
import 'package:nike/data/Model/Entity/banner.dart';
import 'package:nike/data/Repository/banner_repository.dart';
import 'package:nike/data/Repository/productrepository.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            bannerepository: bannerRepository,
            productRepository: productRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Image.asset(
                          'assets/images/nike.png',
                          height: 50,
                        );
                      case 2:
                        return ItemsSchroolPage(
                          lists: state.banners,
                          height: 200,
                          borderRaduis: 50,
                        );

                      case 3:
                        return ProductFilterListWidget(
                            title: 'جدیدترین ها',
                            products: state.latestProduct);
                      case 4:
                        return ProductFilterListWidget(
                            title: 'پرفروش ها', products: state.popularProduct);

                      default:
                        return Container();
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return const Text('Error');
              } else {
                return const Text('State Not Valid');
              }
            },
          ),
        ),
      ),
    );
  }
}

class ProductFilterListWidget extends StatelessWidget {
  const ProductFilterListWidget({
    super.key,
    required this.title,
    required this.products,
  });
  final String title;
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
            TextButton(onPressed: () {}, child: const Text('مشاهده همه'))
          ],
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ProductsItemsListView(
                            borderRaduis: 0,
                            lists: products,
                            index: index,
                          ),
                          Positioned(
                            top: 10,
                            right: 5,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                CupertinoIcons.heart,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(products[index].title)
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
