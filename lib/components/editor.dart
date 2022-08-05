import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? type;
  final EdgeInsets insets;

  Editor({
    required this.controller,
    required this.label,
    required this.insets,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: insets,
      child: TextField(
        autofocus: true,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        style: const TextStyle(
          fontSize: 24.0,
        ),
        keyboardType: type,
      ),
    );
  }
}
