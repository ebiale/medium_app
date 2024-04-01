import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_medium_app/providers/list_provider.dart';
import 'package:rss_medium_app/ui/shared/custom_panel_title.dart';
import 'package:rss_medium_app/ui/shared/custom_text.dart';
import 'package:rss_medium_app/ui/shared/custom_text_animated.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ListProvider>(context, listen: false);

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchHistoryTitle(text: 'Search History'),
            const SizedBox(height: 35),
            Expanded(
              child: Consumer<ListProvider>(
                builder: (context, listProvider, _) {
                  final searchTermList = listProvider.historyList;

                  if (searchTermList.isEmpty) {
                    return const Center(
                        child: CustomWhiteText(text: 'No preview searches'));
                  } else {
                    return ListView.builder(
                      itemCount: searchTermList.length,
                      itemBuilder: (context, index) {
                        final searchTerm = searchTermList[index];
                        return ListTile(
                          title: ListTileItem(searchTerm: searchTerm),
                          onTap: () {
                            listProvider.searchFeed(searchTerm);
                          },
                        );
                      },
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
