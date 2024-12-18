import 'package:flutter/material.dart';
import 'package:mcs/screens/form.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set the app's primary theme color
      ),
      title: 'Producto',
      home: ProductForm(),
    );
  }
}
