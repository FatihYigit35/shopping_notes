import 'package:flutter/material.dart';
import 'package:shopping_notes/data/dummy_items.dart';
import 'package:shopping_notes/widget/new_item.dart';
import 'package:shopping_notes/widget/shopping_note_item.dart';

class ShoppingNotes extends StatefulWidget {
  const ShoppingNotes({super.key});

  @override
  State<ShoppingNotes> createState() => _ShoppingNotesState();
}

class _ShoppingNotesState extends State<ShoppingNotes> {
  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = shoppingNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Shopping Notes'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => ShoppingNoteItem(
          item: list[index],
        ),
      ),
    );
  }
}
