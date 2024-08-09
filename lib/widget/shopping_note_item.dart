import 'package:flutter/material.dart';
import 'package:shopping_notes/model/shopping_item.dart';

class ShoppingNoteItem extends StatelessWidget {
  const ShoppingNoteItem({super.key, required this.item});
  final ShoppingItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 10,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 25,
              height: 25,
              color: item.category.color,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(item.name),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.quantity.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
