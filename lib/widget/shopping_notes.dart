import 'package:flutter/material.dart';
import 'package:shopping_notes/data/dummy_items.dart';
import 'package:shopping_notes/widget/shopping_note_item.dart';

class ShoppingNotes extends StatelessWidget {
  const ShoppingNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final list = shoppingNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Shopping Notes'),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ShoppingNoteItem(
            item: list[index],
          );
        },
      ),
    );
  }
}
