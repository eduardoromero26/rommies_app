part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loadingStarted() = _LoadingStarted;
  const factory UserState.loadedSuccess(UserModel userModel) = _LoadedSuccess;
  const factory UserState.loadedFailed(String message) = _LoadedFailed;
}
