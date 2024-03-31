class RssResponse {
  final String title;
  final String description;
  final List<RssItem>? rssItems;

  RssResponse({required this.title, required this.description, this.rssItems});
}

class RssItem {
  final String title;
  final String? description;
  final String? imageSrc;
  final String? author;
  final String? pubDate;

  RssItem({
    required this.title,
    this.description,
    this.imageSrc,
    this.author,
    this.pubDate,
  });
}
