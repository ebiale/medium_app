import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:rss_medium_app/models/rss_item.dart';
import 'package:rss_medium_app/models/search_history.dart';
import 'dart:convert';

import 'package:xml2json/xml2json.dart';

class ApiService {
  // Base URL of the backend
  static const String baseUrl = 'http://localhost:8081';

  // Private method to make a GET request to the backend
  static Future<dynamic> _getRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      _checkResponse(response);
      return response.body;
    } catch (e) {
      throw Exception('Error in GET request: $e');
    }
  }

  // Private method to check the response status code
  static void _checkResponse(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception('Error in request: ${response.statusCode}');
    }
  }

  // Public method to fetch data from Medium
  static Future<dynamic> fetchMediumData(String mediumSource) async {
    final endpoint = 'fetchMediumData?mediumSource=$mediumSource';
    try {
      final response = await _getRequest(endpoint);
      return response;
    } catch (e) {
      throw Exception('Error fetching Medium data: $e');
    }
  }

  // Public method to get search history
  static Future<List<String>> getSearchHistory(int maxItems) async {
    final endpoint = 'getSearchHistory?maxItems=$maxItems';
    try {
      final response = await _getRequest(endpoint);
      final List<Map<String, dynamic>> dataList =
          List<Map<String, dynamic>>.from(jsonDecode(response));

      final List<SearchHistoryItem> searchHistory = dataList.map((item) {
        return SearchHistoryItem(
          searchTerm: item['searchTerm'],
          timestamp: DateTime.parse(item['timestamp']),
        );
      }).toList();

      searchHistory.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      final List<String> searchTerms =
          searchHistory.map((item) => item.searchTerm).toList();

      return searchTerms;
    } catch (e) {
      throw Exception('Error fetching search history: $e');
    }
  }

  // Public method to get Medium feed
  static Future<RssResponse> getMediumFeed(String source) async {
    final endpoint = '/fetchMediumData?mediumSource=$source';
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));
      _checkResponse(response);
      var channel = _getJsonChannel(response);
      var title = channel['title'];
      var description = channel['description'];

      List<RssItem> rssItems = _getItems(channel);

      return RssResponse(
          title: title, description: description, rssItems: rssItems);
    } catch (e) {
      throw Exception('Error fetching Medium feed: $e');
    }
  }

  static _getJsonChannel(http.Response response) {
    final xml2json = Xml2Json();
    xml2json.parse(response.body);
    final jsonString = xml2json.toParker();
    final Map<String, dynamic> jsonObject = json.decode(jsonString);

    var channel = jsonObject['rss']['channel'];
    return channel;
  }

  static List<RssItem> _getItems(channel) {
    List<dynamic> items = channel['item'];

    List<RssItem> rssItems = [];

    for (var item in items) {
      var title = item['title'];
      var pubDate = item['pubDate'];
      var author = item['dc:creator'];
      var description = item['description'];

      var document = parse(description);

      String? imageUrl;

      var imageElement = document.querySelector('.medium-feed-image a img');

      if (imageElement != null) {
        imageUrl = imageElement.attributes['src'];
      }

      String? itemDescription;
      var snippetElement = document.querySelector('.medium-feed-snippet');
      if (snippetElement != null) {
        itemDescription = snippetElement.text;
      }

      var rssItem = RssItem(
          title: title,
          description: itemDescription,
          pubDate: pubDate,
          author: author,
          imageSrc: imageUrl);

      rssItems.add(rssItem);
    }
    return rssItems;
  }
}
