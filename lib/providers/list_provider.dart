import 'package:flutter/material.dart';
import 'package:rss_medium_app/models/rss_item.dart';
import 'package:rss_medium_app/services/api_service.dart';

class ListProvider extends ChangeNotifier {
  List<String> historyList = [];

  RssResponse? feeds;

  Future<void> fetchHistoryList() async {
    try {
      historyList = await ApiService.getSearchHistory(5);
      notifyListeners();
    } catch (error) {
      historyList = [];
      print('Errog getting the history list: $error');
    }
  }

  Future<void> searchFeed(String mediumSource) async {
    try {
      feeds = await ApiService.getMediumFeed(mediumSource);
      await fetchHistoryList();
      notifyListeners();
    } catch (error) {
      feeds = null;
      print('Errog getting the rss feed list: $error');
    }
  }
}
