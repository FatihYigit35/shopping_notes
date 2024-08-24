import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_notes/data/categories.dart';
import 'package:shopping_notes/data/constants.dart';
import 'package:shopping_notes/data/i18n.dart';
import 'package:shopping_notes/model/categories.dart';
import 'package:shopping_notes/model/request_method.dart';
import 'package:shopping_notes/model/shopping_item.dart';
import 'package:uuid/uuid.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final uuid = const Uuid();
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.other]!;
  var _isSending = false;

  void _addItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSending = true;
      });

      final response = await http.post(
        getFirebaseDBUri(RequestMethod.post),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': _enteredName,
          'quantity': _enteredQuantity,
          'category': _selectedCategory.title,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (!mounted) {
        return;
      }

      final newId = responseData['name'];

      if (newId != null) {
        Navigator.of(context).pop(ShoppingItem(
            id: newId,
            name: _enteredName,
            quantity: _enteredQuantity,
            category: _selectedCategory));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.addNewItemScreenTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 40,
                decoration: InputDecoration(
                  labelText: appLocalizations.name,
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return appLocalizations.pleaseEnterSomeText;
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _enteredName = newValue!;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: appLocalizations.quantity,
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredQuantity.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return appLocalizations.pleaseEnterSomeText;
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredQuantity = int.parse(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: appLocalizations.category,
                      ),
                      value: _selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  color: category.value.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(category.value.title)
                              ],
                            ),
                          )
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () => _formKey.currentState!.reset(),
                    child: Text(appLocalizations.reset),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isSending ? null : _addItem,
                    child: _isSending
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : Text(appLocalizations.save),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
