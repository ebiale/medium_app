import 'package:flutter/material.dart';
import 'package:rss_medium_app/ui/shared/custom_text.dart';

class SearchHistoryTitle extends StatelessWidget {
  const SearchHistoryTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          color: Colors.white24,
          border: Border(bottom: BorderSide(width: 1, color: Colors.white)),
        ),
        child: CustomWhiteText(text: text, fontSize: 24));
  }
}
