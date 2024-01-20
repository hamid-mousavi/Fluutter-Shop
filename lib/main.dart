import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nike/UI/root.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';
import 'package:nike/data/Repository/cart/cart_repository.dart';

import 'UI/Login/login_screen.dart';

void main() async {
  authRepository.loadToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Nick Shop',
        theme: ThemeData(
          fontFamily: 'Vazir',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Directionality(
            textDirection: TextDirection.rtl, child: RootScreen()));
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
