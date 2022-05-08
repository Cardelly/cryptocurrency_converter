import 'package:cryptocurrency_converter/screens/main_screen.dart';
import 'package:flutter/material.dart';

import 'screens/main_screen.dart';

void main() => runApp(CryptocurrencyConverter());

class CryptocurrencyConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.white,
        primaryColor: Colors.grey.shade900,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
