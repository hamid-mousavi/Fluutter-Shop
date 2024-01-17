import 'package:flutter/material.dart';
import 'package:nike/UI/Login/login_screen.dart';
import 'package:nike/data/Model/Entity/Auth.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
