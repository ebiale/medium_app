import 'package:flutter/material.dart';
import 'package:rss_medium_app/history_list.dart';
import 'package:rss_medium_app/rss_feed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rss Medium App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Row(
            children: [
              Container(
                width: 300,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: const HistoryList(),
              ),
              const Expanded(child: RssFeedScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
