import 'package:flutter/material.dart';

class AddTextField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  TextInputType type;
  AddTextField({
    required this.controller,
    required this.hint,
    this.type = TextInputType.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hint, label: Text(hint)),
      keyboardType: type,
    );
  }
}
