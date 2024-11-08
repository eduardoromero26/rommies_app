part of 'expense_bloc.dart';

@freezed
class ExpenseState with _$ExpenseState {
  const factory ExpenseState.initial() = _Initial;
  const factory ExpenseState.loadingStarted() = _LoadingStarted;
  const factory ExpenseState.loadedSuccess(List<ExpenseModel> expensesList) =
      _LoadedSuccess;
  const factory ExpenseState.loadedFailed(String message) = _LoadedFailed;
}
