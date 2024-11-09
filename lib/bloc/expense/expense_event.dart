part of 'expense_bloc.dart';

class ExpenseEvent {
  const ExpenseEvent();
}

class ReadExpensesCollection extends ExpenseEvent {
  const ReadExpensesCollection();
}

class CreateExpense extends ExpenseEvent {
  final ExpenseModel expense;
  const CreateExpense(this.expense);
}

class UpdateExpense extends ExpenseEvent {
  final String expenseId;
  final ExpenseModel expense;
  const UpdateExpense(this.expenseId, this.expense);
}
