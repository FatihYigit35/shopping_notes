import 'package:flutter/material.dart';
import 'package:shopping_notes/model/shopping_item.dart';

class ShoppingNoteItem extends StatelessWidget {
  const ShoppingNoteItem({super.key, required this.item});
  final ShoppingItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 25,
        height: 25,
        color: item.category.color,
      ),
      title: Text(item.name),
      subtitle: Text(item.category.title),
      trailing: Text(item.quantity.toString()),
    );
  }
}
