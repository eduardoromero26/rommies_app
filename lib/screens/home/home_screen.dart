import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:roomies_app/bloc/expense/expense_bloc.dart';
import 'package:roomies_app/models/expense_model.dart';
import 'package:roomies_app/services/secure_storage/secure_storage_service.dart';
import 'package:roomies_app/utils/enum/transaction_type_enum.dart';
import 'package:roomies_app/utils/secure_storage_keys.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showAddTransactionBottomSheet(
                  context, null, 'Agregar nuevo Aporte o Gasto');
            },
            child: const Icon(Icons.add),
          ),
          body: BlocConsumer<ExpenseBloc, ExpenseState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loadedFailed: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                createdSuccess: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Aporte o Gasto creado exitosamente'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                updatedSuccess: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Aporte o Gasto actualizado exitosamente'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                deletedSuccess: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Aporte o Gasto eliminado exitosamente'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                initial: () {
                  context
                      .read<ExpenseBloc>()
                      .add(const ReadExpensesCollection());
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loadedSuccess: (expensesList) {
                  final double balance = expensesList.fold(
                      0,
                      (previousValue, element) => element.type == 0
                          ? previousValue + element.amount
                          : previousValue - element.amount);

                  return CustomScrollView(
                    slivers: [
                      // hero section
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Color.fromARGB(255, 0, 69, 125),
                                Color.fromARGB(255, 0, 69, 125),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 28),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 8.0,
                                ),
                                const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hola!',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          'Bienvenido.',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  height: 80,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Balance del mes'),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        '\$$balance',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 24,
                        ),
                      ),
                      // recent transactions list
                      const SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            'Recent Transactions',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 12,
                        ),
                      ),
                      expensesList.isNotEmpty
                          ? SliverList.builder(
                              itemCount: expensesList.length,
                              itemBuilder: (context, index) {
                                return ExpenseListTile(
                                  expense: expensesList[index],
                                );
                              },
                            )
                          : const SliverFillRemaining(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 48,
                                      child: Icon(
                                        Icons.money_off,
                                        size: 48,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      'No hay transacciones recientes',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 60,
                        ),
                      )
                    ],
                  );
                },
              );
            },
          )),
    );
  }
}

void _showAddTransactionBottomSheet(
    BuildContext context, ExpenseModel? expense, String modalTitle) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddTransactionForm(
          expense: expense,
          modalTitle: modalTitle,
        ),
      );
    },
  );
}

class ExpenseListTile extends StatelessWidget {
  final ExpenseModel? expense;
  const ExpenseListTile({super.key, this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 215, 215, 215)),
            borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          onTap: () {
            _showAddTransactionBottomSheet(
              context,
              expense,
              'Editar Aporte o Gasto',
            );
          },
          title: Text(expense?.title ?? ''),
          subtitle: Text(expense?.description ?? ''),
          leading: CircleAvatar(
              child: expense?.type == 0
                  ? const Icon(Icons.arrow_upward_outlined)
                  : const Icon(Icons.arrow_downward_outlined)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${expense?.type == 0 ? '+' : '-'} \$${expense?.amount.toStringAsFixed(2)}',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: expense?.type == 0 ? Colors.green : Colors.black),
              ),
              Text(DateFormat('dd/MM/yyyy')
                  .format(expense?.date ?? DateTime.now())),
            ],
          ),
        ),
      ),
    );
  }
}

class AddTransactionForm extends StatefulWidget {
  final ExpenseModel? expense;
  final String modalTitle;

  const AddTransactionForm({
    super.key,
    this.expense,
    required this.modalTitle,
  });

  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: widget.expense?.title ?? '');
    final TextEditingController descriptionController =
        TextEditingController(text: widget.expense?.description ?? '');
    final TextEditingController amountController =
        TextEditingController(text: widget.expense?.amount.toString() ?? '');
    final TextEditingController dateController = TextEditingController(
        text: DateFormat('dd/MM/yyyy')
            .format(widget.expense?.date ?? DateTime.now()));

    DateTime selectedDate = widget.expense?.date ?? DateTime.now();
    TransactionType? transactionType = widget.expense?.type == 0
        ? TransactionType.aporte
        : TransactionType.gasto;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(widget.modalTitle,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  if (widget.expense != null)
                    IconButton(
                        onPressed: () {
                          context
                              .read<ExpenseBloc>()
                              .add(DeleteExpense(widget.expense!.id));
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.delete_outline_outlined))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              DropdownButtonFormField<TransactionType>(
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                value: transactionType,
                items: TransactionType.values.map((TransactionType type) {
                  return DropdownMenuItem<TransactionType>(
                    value: type,
                    child: Text(
                        type == TransactionType.aporte ? 'Aporte' : 'Gasto'),
                  );
                }).toList(),
                onChanged: (TransactionType? newValue) {
                  transactionType = newValue!;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La cantidad es obligatoria';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La fecha es obligatoria';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    selectedDate = pickedDate;
                    dateController.text =
                        DateFormat('dd/MM/yyyy').format(selectedDate);
                  }
                },
                controller: dateController,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (states) => Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final String? houseId = await SecureStorageService()
                          .read(SecureStorageKeys.houseId);
                      final String? uid = await SecureStorageService()
                          .read(SecureStorageKeys.uid);
                      widget.expense == null
                          ? context.read<ExpenseBloc>().add(CreateExpense(
                              ExpenseModel(
                                  id: '',
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  amount: double.parse(amountController.text),
                                  type:
                                      transactionType == TransactionType.aporte
                                          ? 0
                                          : 1,
                                  houseId: houseId ?? '',
                                  userId: uid ?? '',
                                  date: selectedDate)))
                          : context.read<ExpenseBloc>().add(UpdateExpense(
                              widget.expense!.id,
                              ExpenseModel(
                                  id: widget.expense!.id,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  amount: double.parse(amountController.text),
                                  type:
                                      transactionType == TransactionType.aporte
                                          ? 0
                                          : 1,
                                  houseId: houseId ?? '',
                                  userId: uid ?? '',
                                  date: selectedDate)));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Guardar Cambios',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}
