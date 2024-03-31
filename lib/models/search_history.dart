class SearchHistoryItem {
  final String searchTerm;
  final DateTime timestamp;

  SearchHistoryItem({
    required this.searchTerm,
    required this.timestamp,
  });

  factory SearchHistoryItem.fromJson(Map<String, dynamic> json) {
    return SearchHistoryItem(
      searchTerm: json['searchTerm'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() => {
        'searchTerm': searchTerm,
        'timestamp': timestamp.toIso8601String(),
      };
}
