import 'package:flutter/material.dart';
import 'package:rss_medium_app/services/api_service.dart';
import 'package:rss_medium_app/ui/shared/custom_panel_title.dart';
import 'package:rss_medium_app/ui/shared/custom_text.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
            const SearchHistoryTitle(text: 'Search History'),
            const SizedBox(height: 35),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: _searchHistoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      value: 0.5,
                    );
                  } else if (snapshot.hasError) {
                    return CustomWhiteText(text: 'Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final searchTermList = snapshot.data!;

                    return ListView.builder(
                      itemCount: searchTermList.length,
                      itemBuilder: (context, index) {
                        final searchTerm = searchTermList[index];
                        return ListTile(
                            title: CustomWhiteText(
                                text: searchTerm, fontSize: 18));
                      },
                    );
                  } else {
                    return const CustomWhiteText(
                      text: 'Not available data',
                    );
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
