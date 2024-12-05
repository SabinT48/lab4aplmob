import 'package:flutter/material.dart';
import 'package:pam1/presentation/screens/home_page.dart'; // Importă HomePage-ul

void main() {
  runApp(DrinkStoreApp());
}

class DrinkStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Folosește HomePage ca ecran principal
    );
  }
}
