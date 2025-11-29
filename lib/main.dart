import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:somiti_app/firebase_options.dart';
import 'package:somiti_app/presentation/screens/admin/borrower_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Management App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const BorrowerListScreen(),
    );
  }
}