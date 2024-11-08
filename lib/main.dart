import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roomies_app/bloc/auth/auth_bloc.dart';
import 'package:roomies_app/bloc/expense/expense_bloc.dart';
import 'package:roomies_app/bloc/user/user_bloc.dart';
import 'package:roomies_app/firebase_options.dart';
import 'package:roomies_app/screens/splash/splash_screen.dart';
import 'package:roomies_app/services/auth/auth_service.dart';
import 'package:roomies_app/services/expenses/expenses_service.dart';
import 'package:roomies_app/services/user/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthService()),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(UserService()),
        ),
        BlocProvider<ExpenseBloc>(
          create: (context) => ExpenseBloc(ExpensesService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rommies App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 69, 125),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
