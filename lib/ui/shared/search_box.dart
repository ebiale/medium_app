import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_medium_app/providers/list_provider.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context, listen: false);
    final TextEditingController textEditingController = TextEditingController();

    return Consumer<ListProvider>(
      builder: (context, value, _) {
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
            suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (textEditingController.text.isNotEmpty) {
                    listProvider.searchFeed(textEditingController.text);
                    textEditingController.clear();
                  }
                }));

        return TextField(
          decoration: inputDecoration,
          controller: textEditingController,
        );
      },
    );
  }
}
