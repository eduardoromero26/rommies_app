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
              _showAddTransactionBottomSheet(context);
            },
            child: const Icon(Icons.add),
          ),
          body: BlocConsumer<ExpenseBloc, ExpenseState>(
            listener: (context, state) {},
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
                  print(expensesList);
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
                                          'Hola, Josue!',
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
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Balance del mes'),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        '\$2,430',
                                        style: TextStyle(
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
                      SliverList.builder(
                        itemCount: expensesList.length,
                        itemBuilder: (context, index) {
                          return ExpenseListTile(
                            title: expensesList[index].title,
                            description: expensesList[index].description,
                            amount: expensesList[index].amount,
                            type: expensesList[index].type,
                            date: expensesList[index].date,
                          );
                        },
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

  void _showAddTransactionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddTransactionForm(),
        );
      },
    );
  }
}

class ExpenseListTile extends StatelessWidget {
  final String title;
  final String? description;
  final double amount;
  final int type;
  final DateTime date;
  const ExpenseListTile({
    super.key,
    required this.title,
    this.description,
    required this.amount,
    required this.type,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 215, 215, 215)),
            borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: Text(title),
          subtitle: Text(description ?? ''),
          leading: CircleAvatar(
              child: type > 0
                  ? const Icon(Icons.arrow_upward_outlined)
                  : const Icon(Icons.arrow_downward_outlined)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${type > 0 ? '+' : '-'} \$${amount.toStringAsFixed(2)}',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: type > 0 ? Colors.green : Colors.black),
              ),
              Text(DateFormat('dd/MM/yyyy').format(date)),
            ],
          ),
        ),
      ),
    );
  }
}

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  double _amount = 0;
  DateTime _selectedDate = DateTime.now();
  TransactionType _transactionType = TransactionType.aporte;

  @override
  Widget build(BuildContext context) {
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Agregar nuevo Aporte o Gasto',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onSaved: (value) {
                  _title = value!;
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
                value: _transactionType,
                items: TransactionType.values.map((TransactionType type) {
                  return DropdownMenuItem<TransactionType>(
                    value: type,
                    child: Text(
                        type == TransactionType.aporte ? 'Aporte' : 'Gasto'),
                  );
                }).toList(),
                onChanged: (TransactionType? newValue) {
                  setState(() {
                    _transactionType = newValue!;
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onSaved: (value) {
                  if (value != '') _amount = double.parse(value ?? '0');
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
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
                    initialDate: _selectedDate,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _selectedDate) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                controller: TextEditingController(
                  text: "${_selectedDate.toLocal()}".split(' ')[0],
                ),
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
                      context.read<ExpenseBloc>().add(CreateExpense(
                          ExpenseModel(
                              id: '',
                              title: _title,
                              description: _description,
                              amount: _amount,
                              type: _transactionType.index,
                              houseId: houseId ?? '',
                              userId: uid ?? '',
                              date: _selectedDate)));
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
