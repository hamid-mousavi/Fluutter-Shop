import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/data/Repository/Auth/AuthRepository.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool loginMode;
  final IAuthRepository authRepositoru;
  AuthBloc(this.authRepositoru, {this.loginMode = true})
      : super(AuthInitial(loginMode)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthBtnClicked) {
          emit(AuthLoading(loginMode));
          if (loginMode) {
            await authRepositoru.login(event.userName, event.password);
            emit(AuthSuccess(loginMode));
          } else {
            await authRepositoru.register(event.userName, event.password);
            emit(AuthSuccess(loginMode));
          }
        } else if (event is AuthModeChanged) {
          loginMode = !loginMode;
          emit(AuthInitial(loginMode));
        }
      } catch (e) {
        emit(AuthError(loginMode, error: e.toString()));
      }
    });
  }
}
