import 'package:flutter/material.dart';
import 'package:rss_medium_app/ui/views/rss_feed.dart';
import 'package:rss_medium_app/ui/shared/search_box.dart';

class FeedsView extends StatelessWidget {
  const FeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SizedBox(
        height: size.height,
        child: const Column(
          children: [
            CustomSearchBar(),
            SizedBox(height: 20),
            Expanded(child: RssFeedScreen())
          ],
        ),
      ),
    );
  }
}
