import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/UI/Login/login_screen.dart';
import 'package:nike/UI/cart/bloc/cart_bloc.dart';
import 'package:nike/data/Model/Entity/add_to_cart_response.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';
import 'package:nike/data/Repository/cart/cart_repository.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;

  @override
  void initState() {
    AuthRepository.authChangeNotifier.addListener(athChangeNotifierListner);
    super.initState();
  }

  void athChangeNotifierListner() {
    cartBloc?.add(AuthStateChangedEvent(
        authInfo: AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier.removeListener(athChangeNotifierListner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(),
      body: listViewItems(),
    );
  }

  Widget listViewItems() {
    return BlocProvider<CartBloc>(
      create: (context) {
        final bloc = CartBloc(cartRepository);
        cartBloc = bloc;
        bloc.add(
            CartOnStarted(authInfo: AuthRepository.authChangeNotifier.value));
        return bloc;
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadSuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: state.items.cartsItems.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.items.cartsItems.length) {
                          return CartInfo(state: state);
                        } else {
                          final item = state.items.cartsItems[index];
                          return CartItemWidget(
                            item: item,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartError) {
            return Text(state.error.toString());
          } else if (state is AuthRequierd) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('لطفا وارد حساب کاربری خود شوید'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                      },
                      child: const Text('ورود'))
                ],
              ),
            );
          } else {
            return const Text('state not valid');
          }
        },
      ),
    );
  }
}

class CartInfo extends StatelessWidget {
  final CartLoadSuccess state;

  const CartInfo({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('جزئیات خرید'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('مبلغ کل خرید'),
                Text(state.items.totalPrice.toString()),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('هرینه ارسال'),
                Text('رایگان'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('مبلغ قابل پرداخت'),
                Text(state.items.payablePrice.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: const BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey)],
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 70,
                  child: Image.network(item.productEntity.image),
                ),
                Text(item.productEntity.title)
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text('تعداد'),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      item.count < 5
                          ? BlocProvider.of<CartBloc>(context).add(
                              IncreaseItemsCartBtn(item.count,
                                  cartItemId: item.cartItemId))
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('نمیتواند بیش از 5 باشد')));
                    },
                    icon: const Icon(CupertinoIcons.plus)),
                item.changeCountBtn
                    ? const CupertinoActivityIndicator()
                    : Text(item.count.toString()),
                IconButton(
                    onPressed: () {
                      item.count > 1
                          ? BlocProvider.of<CartBloc>(context).add(
                              DecreaseItemsCartBtn(
                                  count: item.count,
                                  cartItemId: item.cartItemId))
                          : BlocProvider.of<CartBloc>(context)
                              .add(DeleteFromCartBtn(cartId: item.cartItemId));
                    },
                    icon: const Icon(CupertinoIcons.minus)),
                const Expanded(child: SizedBox()),
                Column(
                  children: [
                    Text(
                      '${item.productEntity.previousPrice}  تومان',
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough),
                    ),
                    Text('${item.productEntity.price}  تومان'),
                  ],
                ),
              ],
            ),
            const Divider(),
            InkWell(
              onTap: () {
                BlocProvider.of<CartBloc>(context)
                    .add(DeleteFromCartBtn(cartId: item.cartItemId));
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: item.progressDeletingBtn
                      ? const CupertinoActivityIndicator()
                      : Text('حذف از سبد خرید',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
