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
  }
}
