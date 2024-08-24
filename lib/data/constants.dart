import 'package:flutter/material.dart';
import 'package:shopping_notes/model/request_method.dart';

Uri getFirebaseDBUri(RequestMethod method, {String? id}) {
  switch (method) {
    case RequestMethod.get:
    case RequestMethod.post:
      return Uri.https(
          'fatih-yigit-default-rtdb.europe-west1.firebasedatabase.app',
          'shopping_notes.json');
    case RequestMethod.put:
    case RequestMethod.patch:
    case RequestMethod.delete:
      assert(id != null);
      return Uri.https(
          'fatih-yigit-default-rtdb.europe-west1.firebasedatabase.app',
          'shopping_notes/$id.json');
  }
}

void showSnackbar(
  BuildContext context, {
  required String message,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(message),
    ),
  );
}
