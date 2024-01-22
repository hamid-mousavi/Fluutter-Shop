import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nike/UI/root.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';

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
            colorScheme: const ColorScheme.light(
              primary: Color(0xff217CF3),
              secondary: Color(0xff262A35),
              background: Colors.grey,
            )),
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
