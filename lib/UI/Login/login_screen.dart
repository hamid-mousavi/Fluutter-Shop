import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/UI/Login/bloc/auth_bloc_bloc.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool showPassword = false;

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController =
      TextEditingController(text: 'test@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (context) {
          final myBloc = AuthBloc(authRepository);
          myBloc.stream.forEach((state) {
            if (state is AuthSuccess) {
              Navigator.of(context).pop();
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error.toString())));
            }
          });
          myBloc.add(AuthScreenStarted());
          return myBloc;
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) {
              return current is AuthError ||
                  current is AuthInitial ||
                  current is AuthLoading;
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/nike.png', width: 100),
                  const Text(
                    'خوش آمدید',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    state.isLoginMode == true
                        ? 'لطفا وارد حساب کاربری خود شوید'
                        : 'لطفا ثبت نام کنید ',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                          hintText: ' ایمیل',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1)))),
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
                          BlocProvider.of<AuthBloc>(context).add(AuthBtnClicked(
                              userName: userNameController.text,
                              password: passwordController.text));
                        },
                        child: (state is AuthLoading)
                            ? const CircularProgressIndicator(
                                color: Colors.amber,
                              )
                            : Text(state.isLoginMode == true
                                ? 'ورود'
                                : 'ثبت نام')),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.isLoginMode == true
                          ? 'حساب کاربری ندارید؟'
                          : 'حساب کاربری دارید؟'),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthModeChanged());
                        },
                        child: Text(
                          state.isLoginMode == true ? 'ثبت نام ' : 'ورود ',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
