part of 'expense_bloc.dart';

@freezed
class ExpenseState with _$ExpenseState {
  const factory ExpenseState.initial() = _Initial;
  const factory ExpenseState.loadingStarted() = _LoadingStarted;
  const factory ExpenseState.loadedSuccess(List<ExpenseModel> expensesList) =
      _LoadedSuccess;
  const factory ExpenseState.loadedFailed(String message) = _LoadedFailed;
  const factory ExpenseState.deletedSuccess() = _DeletedSuccess;
  const factory ExpenseState.deletedFailed(String message) = _DeletedFailed;
  const factory ExpenseState.updatedSuccess() = _UpdatedSuccess;
  const factory ExpenseState.updatedFailed(String message) = _UpdatedFailed;
  const factory ExpenseState.createdSuccess() = _CreatedSuccess;
  const factory ExpenseState.createdFailed(String message) = _CreatedFailed;
}
