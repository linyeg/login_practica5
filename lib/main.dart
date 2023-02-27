import 'package:flutter/material.dart';

import 'singup.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'login': (context) => const MainLogInScreen(),
        'Singup': (context) => const SingUpScreen()
      },
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
    );
  }
}
