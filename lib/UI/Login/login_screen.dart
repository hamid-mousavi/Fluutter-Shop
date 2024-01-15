import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isLogin = true;
bool showPassword = false;

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController =
      TextEditingController(text: 'test@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/nike.png', width: 100),
            const Text(
              'خوش آمدید',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              isLogin == true
                  ? 'لطفا وارد حساب کاربری خود شوید'
                  : 'لطفا ثبت نام کنید ',
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 12),
            TextField(
                controller: userNameController,
                decoration: const InputDecoration(
                    hintText: ' ایمیل',
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            const SizedBox(height: 12),
            TextField(
                controller: passwordController,
                obscureText: showPassword == false ? true : false,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(showPassword == true
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash)),
                    hintText: 'رمز عبور',
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1)))),
            const SizedBox(height: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor)),
                  onPressed: () {
                    authRepository.login(
                        userNameController.text, passwordController.text);
                  },
                  child: Text(isLogin == true ? 'ورود' : 'ثبت نام')),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isLogin == true
                    ? 'حساب کاربری ندارید؟'
                    : 'حساب کاربری دارید؟'),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(
                    isLogin == true ? 'ثبت نام ' : 'ورود ',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
