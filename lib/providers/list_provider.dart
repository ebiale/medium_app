import 'package:flutter/material.dart';
import 'package:rss_medium_app/models/rss_item.dart';
import 'package:rss_medium_app/models/search_history.dart';

class ListProvider extends ChangeNotifier {
  List<SearchHistoryItem> historyList = [];

  RssResponse? response;

  Future<void> refreshHistoryList(List<SearchHistoryItem> historyList) async {
    this.historyList = historyList;
  }

  Future<void> refreshFeed(RssResponse? response) async {
    this.response = response;
  }
}
