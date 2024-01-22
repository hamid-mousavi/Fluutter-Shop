import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/UI/Login/login_screen.dart';
import 'package:nike/data/Model/Entity/Auth.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: ValueListenableBuilder<AuthInfo?>(
          valueListenable: AuthRepository.authChangeNotifier,
          builder: (context, authState, child) {
            bool isAuthenticated =
                authState != null && authState.accessTocken.isNotEmpty;
            return isAuthenticated
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('خوش آمدید'),
                      TextButton(
                          onPressed: () {
                            authRepository.signOut();
                          },
                          child: Text('خروج')),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('لطفا وارد حساب کاربری خود شوید'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          child: const Text('ورود'))
                    ],
                  );
          },
        ),
      ),
    );
  }
}
