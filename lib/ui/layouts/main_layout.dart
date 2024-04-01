import 'package:flutter/material.dart';
import 'package:rss_medium_app/ui/views/feeds_view.dart';
import 'package:rss_medium_app/ui/views/history_list.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              width: 300,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: const HistoryList(),
            ),
            const Expanded(child: FeedsView()),
          ],
        ),
      ),
    );
  }
}
