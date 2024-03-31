import 'package:flutter/material.dart';
import 'package:rss_medium_app/services/api_service.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late Future<List<String>> _searchHistoryFuture;

  @override
  void initState() {
    super.initState();
    _searchHistoryFuture = ApiService.getSearchHistory(5);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.white)),
              ),
              child: const Text('Search History',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            const SizedBox(height: 35),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: _searchHistoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}', style: TextStyle(
                                               color: Colors.white));
                  } else if (snapshot.hasData) {
                    final searchTermList = snapshot.data!;

                    return ListView.builder(
                      itemCount: searchTermList.length,
                      itemBuilder: (context, index) {
                        final searchTerm = searchTermList[index];
                        return ListTile(
                          title: Text(searchTerm, style: TextStyle(
                              color: Colors.white, fontSize: 18)),
                        );
                      },
                    );
                  } else {
                    return const Text('Not available data', style: TextStyle(
                        color: Colors.white));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
