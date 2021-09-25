class MessageListController {
  /// Call this function to load further data
  Future<void> Function({QueryDirection direction}) paginateData;
}

enum QueryDirection {
  /// Query earlier messages
  top,

  /// Query later messages
  bottom,
}