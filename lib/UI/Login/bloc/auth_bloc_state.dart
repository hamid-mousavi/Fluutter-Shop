part of 'auth_bloc_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthError extends AuthState {
  final String error;

  const AuthError({required this.error});
}
