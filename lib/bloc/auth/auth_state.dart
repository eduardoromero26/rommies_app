part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loadingStarted() = _LoadingStarted;
  const factory AuthState.loadedSuccess(TokenModel uid) = _LoadedSuccess;
  const factory AuthState.loadedFailed(String message) = _LoadedFailed;
}
