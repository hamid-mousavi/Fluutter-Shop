part of 'auth_bloc_bloc.dart';

sealed class AuthState extends Equatable {
  final bool isLoginMode;
  const AuthState(this.isLoginMode);

  @override
  List<Object> get props => [isLoginMode];
}

final class AuthInitial extends AuthState {
  const AuthInitial(bool isLoginMode) : super(isLoginMode);
}

final class AuthSuccess extends AuthState {
  const AuthSuccess(bool isLoginMode) : super(isLoginMode);
}

final class AuthError extends AuthState {
  final String error;

  const AuthError(bool isLoginMode, {required this.error}) : super(isLoginMode);
}

final class AuthLoading extends AuthState {
  const AuthLoading(bool isLoginMode) : super(isLoginMode);
}
