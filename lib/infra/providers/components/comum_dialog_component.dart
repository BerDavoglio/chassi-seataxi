import 'package:flutter/material.dart';

Future<void> comumDialog(
    BuildContext context, String title, String content, Function func) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: func(),
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}
