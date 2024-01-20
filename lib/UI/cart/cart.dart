import 'package:flutter/material.dart';
import 'package:nike/UI/Login/login_screen.dart';
import 'package:nike/data/Model/Entity/Auth.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';
import 'package:nike/data/Repository/cart/cart_repository.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    cartRepository.cartItemList().then(
      (value) {
        debugPrint(value.toString());
      },
    ).catchError((e) {
      debugPrint(e.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, authState, child) {
          bool isAuthenticated =
              authState != null && authState.accessTocken.isNotEmpty;
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(isAuthenticated
                      ? 'خوش آمدید'
                      : 'لطفا وارد حساب کاربری شوید'),
                  !isAuthenticated
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                          },
                          child: const Text('ورود'))
                      : ElevatedButton(
                          onPressed: () {
                            authRepository.signOut();
                          },
                          child: const Text('خروج')),
                  isAuthenticated
                      ? ElevatedButton(
                          onPressed: () {
                            authRepository.refreshTocken();
                          },
                          child: Text('refresh token'))
                      : Text('data'),
                ]),
          );
        },
      ),
    );
  }
}
