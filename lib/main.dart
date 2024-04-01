import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_medium_app/providers/list_provider.dart';
import 'package:rss_medium_app/ui/layouts/main_layout.dart';

void main() {
  runApp(const ProviderApp());
}

class ProviderApp extends StatelessWidget {
  const ProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListProvider(),
      child: const MyApp(),
    );
  }
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
      home: const MainLayout(),
    );
  }
}
