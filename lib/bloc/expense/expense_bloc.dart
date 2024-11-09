import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roomies_app/models/expense_model.dart';
import 'package:roomies_app/services/expenses/expenses_service.dart';

part 'expense_event.dart';
part 'expense_state.dart';
part 'expense_bloc.freezed.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpensesService expensesService;
  ExpenseBloc(this.expensesService) : super(const ExpenseState.initial()) {
    on<ReadExpensesCollection>((event, emit) async {
      try {
        emit(const ExpenseState.loadingStarted());
        final List<ExpenseModel> expensesList =
            await expensesService.readAllExpenses();
        emit(ExpenseState.loadedSuccess(expensesList));
      } catch (e) {
        emit(ExpenseState.loadedFailed(e.toString()));
      }
    });
    on<CreateExpense>((event, emit) async {
      try {
        emit(const ExpenseState.loadingStarted());
        await expensesService.createExpense(event.expense);
        emit(const ExpenseState.createdSuccess());
        emit(const ExpenseState.initial());
      } catch (e) {
        emit(ExpenseState.loadedFailed(e.toString()));
      }
    });
    on<UpdateExpense>((event, emit) async {
      try {
        emit(const ExpenseState.loadingStarted());
        await expensesService.updateExpense(event.expenseId, event.expense);
        emit(const ExpenseState.updatedSuccess());
        emit(const ExpenseState.initial());
      } catch (e) {
        emit(ExpenseState.loadedFailed(e.toString()));
      }
    });

    on<DeleteExpense>((event, emit) async {
      try {
        emit(const ExpenseState.loadingStarted());
        await expensesService.deleteExpense(event.expenseId);
        emit(const ExpenseState.deletedSuccess());
        emit(const ExpenseState.initial());
      } catch (e) {
        emit(ExpenseState.loadedFailed(e.toString()));
      }
    });
  }
}
