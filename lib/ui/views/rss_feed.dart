import 'package:flutter/material.dart';
import 'package:rss_medium_app/models/rss_item.dart';
import 'package:rss_medium_app/services/api_service.dart';
import 'package:rss_medium_app/ui/shared/custom_text.dart';

class RssFeedScreen extends StatefulWidget {
  const RssFeedScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RssFeedScreenState createState() => _RssFeedScreenState();
}

class _RssFeedScreenState extends State<RssFeedScreen> {
  late Future<RssResponse> _feedFuture =
      Future.value(RssResponse(title: '', description: '', rssItems: []));

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    try {
      final feed = await ApiService.getMediumFeed('the-atlantic');
      setState(() {
        _feedFuture = Future.value(feed);
      });
    } catch (e) {
      print('Error loading feed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RssResponse>(
      future: _feedFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final feedResponse = snapshot.data!;
          return Center(
            child: Column(
              children: [
                // response header
                CustomText(
                    text: feedResponse.title,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 10),
                CustomText(
                    text: feedResponse.description,
                    fontSize: 18,
                    color: Colors.grey),
                const SizedBox(height: 20),

                // list of articles
                Expanded(
                    child: ListView.builder(
                        itemCount: feedResponse.rssItems?.length,
                        itemBuilder: (context, index) {
                          final item = feedResponse.rssItems?[index];
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
                        }))
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}

class _ItemView extends StatelessWidget {
  const _ItemView({
    required this.item,
  });

  final RssItem? item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // athor
          _SmallText(value: item?.author ?? ''),
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
                        fontFamily: 'Merriweather'),
                    const SizedBox(height: 8),
                    CustomText(
                      text: item?.description ?? '',
                      fontSize: 14,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              //image
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
            child: _SmallText(value: item?.pubDate ?? ''),
          ),
        ],
      ),
    );
  }
}

class _SmallText extends StatelessWidget {
  const _SmallText({
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(fontSize: 10, color: Colors.grey),
    );
  }
}
