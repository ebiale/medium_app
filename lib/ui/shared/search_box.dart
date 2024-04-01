import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10));

    final inputDecoration = InputDecoration(
        hintText: "Search for Medium user or account",
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        filled: true,
        fillColor: Colors.white,
        suffixIcon:
            IconButton(icon: const Icon(Icons.search), onPressed: () {}));
    return TextField(
      decoration: inputDecoration,
    );
  }
}
