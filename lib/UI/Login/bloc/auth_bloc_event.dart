part of 'auth_bloc_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthScreenStarted extends AuthEvent {}

class AuthBtnClicked extends AuthEvent {
  final String userName;
  final String password;

  const AuthBtnClicked({required this.userName, required this.password});
}

class AuthModeChanged extends AuthEvent {
  bool authMode = true;
}
