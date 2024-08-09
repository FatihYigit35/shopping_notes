import 'package:flutter/material.dart';
import 'package:shopping_notes/data/dummy_items.dart';
import 'package:shopping_notes/widget/shopping_list_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final list = shoppingNotes;
    return MaterialApp(
      title: 'Flutter Groceries',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 42, 51, 59),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Your Shopping Notes'),
          ),
          body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ShoppingListItem(item: list[index]);
            },
          )),
    );
  }
}
