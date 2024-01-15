import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepositoru;
  AuthBloc(this.authRepositoru) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      if (event is AuthModeChanged) {
        event.authMode = !event.authMode;
      }
    });
  }
}
