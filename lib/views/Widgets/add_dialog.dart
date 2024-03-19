import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {
  AddDialog(
      {required this.controller,
      required this.onAdded,
      required this.onCancel,
      super.key});
  final TextEditingController controller;
  VoidCallback onCancel;
  VoidCallback onAdded;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajoutez une liste'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Entrez le nom de la nouvelle liste',
        ),
      ),
      actions: [
        TextButton(onPressed: onCancel, child: const Text('Annuler')),
        TextButton(onPressed: onAdded, child: const Text('Valider')),
      ],
    );
  }
}
