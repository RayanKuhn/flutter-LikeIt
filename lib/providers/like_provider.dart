import 'package:flutter/material.dart';

class LikeProvider with ChangeNotifier {
  final Set<String> _likedImageIds = {};

  Set<String> get likedImageIds => _likedImageIds;

  void toggleLike(String imageId) {
    if (_likedImageIds.contains(imageId)) {
      _likedImageIds.remove(imageId);
    } else {
      _likedImageIds.add(imageId);
    }
    notifyListeners();
  }

  bool isLiked(String imageId) => _likedImageIds.contains(imageId);
}
