import 'package:flutter/foundation.dart';

class PlayerProvider extends ChangeNotifier {
  bool _isFavorite = false;
  bool _isPlaying = false;

  bool get isFavorite => _isFavorite;

  bool get isPlaying => _isPlaying;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void togglePlaying() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }
}
