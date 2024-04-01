import 'package:flutter/material.dart';
import 'package:rss_medium_app/models/rss_item.dart';
import 'package:rss_medium_app/services/api_service.dart';

class RssFeedScreen extends StatefulWidget {
  const RssFeedScreen({super.key});

  @override
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
      // Manejar cualquier error que pueda ocurrir al cargar el feed
      print('Error loading feed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SizedBox(
        height: size.height,
        child: FutureBuilder<RssResponse>(
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
                    Text(feedResponse.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(feedResponse.description,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey)),
                    const SizedBox(height: 20),
                    Expanded(
                        child: ListView.builder(
                            itemCount: feedResponse.rssItems?.length,
                            itemBuilder: (context, index) {
                              final item = feedResponse.rssItems?[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item?.author ?? '',
                                          style: const TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item?.title ?? '',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Merriweather',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    item?.description ?? '',
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            item?.pubDate ?? '',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
        ),
      ),
    );
  }
}
