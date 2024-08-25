import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_notes/data/categories.dart';
import 'package:shopping_notes/data/constants.dart';
import 'package:shopping_notes/l10n/i18n.dart';
import 'package:shopping_notes/model/category.dart';
import 'package:shopping_notes/model/request_method.dart';
import 'package:shopping_notes/model/shopping_item.dart';
import 'package:shopping_notes/widget/new_item.dart';
import 'package:shopping_notes/widget/shopping_note_item.dart';

class ShoppingNotes extends StatefulWidget {
  const ShoppingNotes({super.key});

  @override
  State<ShoppingNotes> createState() => _ShoppingNotesState();
}

class _ShoppingNotesState extends State<ShoppingNotes> {
  List<ShoppingItem> _shoppingNotes = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final response = await http.get(getFirebaseDBUri(RequestMethod.get));

    if (response.statusCode >= 400) {
      setState(() {
        _error = 'Something went wrong';
      });
    }

    final Map<String, dynamic>? listData = jsonDecode(response.body);

    final List<ShoppingItem> loadedNotes = [];

    if (!mounted) {
      return;
    }

    if (listData != null) {
      for (final item in listData.entries) {
        final Category category = categories.entries
            .firstWhere(
                (element) => element.value.title == item.value['category'])
            .value;
        final String name = item.value['name'];
        final int quantity = item.value['quantity'];

        loadedNotes.add(
          ShoppingItem(
            id: item.key,
            name: name,
            quantity: quantity,
            category: category,
          ),
        );
      }
    }

    setState(() {
      _shoppingNotes = loadedNotes;
      _isLoading = false;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _shoppingNotes.add(newItem);
    });
  }

  void _removeItemFromList(ShoppingItem item) async {
    //final index = _shoppingNotes.indexOf(item);

    final response = await http.delete(
      getFirebaseDBUri(RequestMethod.delete, id: item.id),
    );

    if (!mounted) {
      return;
    }

    if (response.statusCode == 200) {
      setState(() {
        _shoppingNotes.remove(item);
      });

      showSnackbar(
        context,
        message: 'Shopping note deleted.',
      );
    }

    if (response.statusCode >= 400) {
      showSnackbar(
        context,
        message: 'An error occurred while deleting, try again.',
      );
    }

    // ScaffoldMessenger.of(context).clearSnackBars();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     duration: const Duration(seconds: 3),
    //     content: const Text('Shopping note deleted.'),
    //     action: SnackBarAction(
    //         label: 'Undo',
    //         onPressed: () {
    //           setState(() {
    //             _shoppingNotes.insert(index, item);
    //           });
    //         }),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    AppTranslations.init(context);

    Widget content = Scaffold(
      body: Center(
        child: Text(appLocalizations.noItemsAddedYet),
      ),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

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

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.shoppingNotesTitle),
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
