import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roomies_app/models/token_model.dart';
import 'package:roomies_app/services/auth_service.dart';

part 'auth_bloc.freezed.dart';
part 'auth_events.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  AuthBloc(this.authService) : super(const AuthState.initial()) {
    on<LoginWithEmail>((event, emit) async {
      try {
        emit(const AuthState.loadingStarted());
        final user =
            await authService.loginWithEmail(event.email, event.password);
        emit(AuthState.loadedSuccess(TokenModel(uid: user.uid)));
      } catch (e) {
        emit(AuthState.loadedFailed(e.toString()));
        emit(const AuthState.initial());
      }
    });
  }
}
