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

  void _removeItemFromList(ShoppingItem item) {
    final index = _shoppingNotes.indexOf(item);

    setState(() {
      _shoppingNotes.remove(item);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Shopping note deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _shoppingNotes.insert(index, item);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Scaffold(
      body: Center(
        child: Text('No items added yet.'),
      ),
    );

    if (_shoppingNotes.isNotEmpty) {
      content = ListView.builder(
        itemCount: _shoppingNotes.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(_shoppingNotes[index].id),
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.red,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Row(
              children: [
                Icon(Icons.delete),
                Spacer(),
                Icon(Icons.delete),
              ],
            ),
          ),
          onDismissed: (direction) {
            _removeItemFromList(_shoppingNotes[index]);
          },
          child: ShoppingNoteItem(
            item: _shoppingNotes[index],
          ),
        ),
      );
    }

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
      body: content,
    );
  }
}
