import 'package:flutter/material.dart';
import 'package:shopping_notes/model/shopping_item.dart';
import 'package:shopping_notes/widget/new_item.dart';
import 'package:shopping_notes/widget/shopping_note_item.dart';

class ShoppingNotes extends StatefulWidget {
  const ShoppingNotes({super.key});

  @override
  State<ShoppingNotes> createState() => _ShoppingNotesState();
}

class _ShoppingNotesState extends State<ShoppingNotes> {
  final List<ShoppingItem> _shoppingNotes = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<ShoppingItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    if (newItem != null) {
      _addItemToList(newItem);
    }
  }

  void _addItemToList(ShoppingItem item) {
    setState(() {
      _shoppingNotes.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        itemCount: _shoppingNotes.length,
        itemBuilder: (context, index) => ShoppingNoteItem(
          item: _shoppingNotes[index],
        ),
      ),
    );
  }
}
