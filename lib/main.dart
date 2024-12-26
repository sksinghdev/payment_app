// ignore_for_file: depend_on_referenced_packages
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'core/feature_injection.dart';
import 'features/login/presentation/login_screen.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'features/transaction/presentation/page/history_page.dart';



void main() async  {
   WidgetsFlutterBinding.ensureInitialized();
 
 await setupDependencies();

  runApp(const MainApp());
} 
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
