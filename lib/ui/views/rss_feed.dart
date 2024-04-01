import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:rss_medium_app/models/rss_item.dart';
import 'package:rss_medium_app/providers/list_provider.dart';
import 'package:rss_medium_app/ui/shared/custom_text.dart';

class RssFeedScreen extends StatelessWidget {
  const RssFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(
      builder: (context, listProvider, _) {
        final feedResponse = listProvider.feeds;

        return Center(
          child: Column(
            children: [
              // response header
              CustomText(
                text: feedResponse?.title ?? '',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: feedResponse?.description ?? '',
                fontSize: 18,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),

              // list of articles
              Expanded(
                child: ListView.builder(
                  itemCount: feedResponse?.rssItems?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = feedResponse?.rssItems?[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _ItemView(item: item),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ItemView extends StatelessWidget {
  const _ItemView({required this.item});

  final RssItem? item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // athor
          CustomText(
              text: item?.author ?? '', fontSize: 10, color: Colors.grey),
          const SizedBox(height: 4),

          // article content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    CustomText(
                      text: item?.title ?? '',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Merriweather',
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text: item?.description ?? '',
                      fontSize: 14,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item?.htmlDescription != null)
                      Html(data: item?.htmlDescription, style: {
                        "img": Style(width: Width(70), height: Height(70)),
                      })
                  ],
                ),
              ),
              const SizedBox(width: 10),

              //image
              if (item?.imageSrc != null)
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    item?.imageSrc ?? '',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          //date
          Align(
              alignment: Alignment.centerRight,
              child: CustomText(
                  text: item?.pubDate ?? '', fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}
