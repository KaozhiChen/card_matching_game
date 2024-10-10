import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:math';

class GameState with ChangeNotifier {
  List<String> _numList = [];
  List<bool> _flipped = List.filled(16, false);
  List<bool> _matched = List.filled(16, false);
  int? _firstFlippedIndex;
  int _score = 0;
  int _matchedPairs = 0;
  Timer? _timer;
  int _timeElapsed = 0;
  bool _gameOver = false;

  GameState() {
    _initializeGame();
  }

  void _initializeGame() {
    _numList = [];
    for (int i = 1; i <= 8; i++) {
      _numList.add(i.toString());
      _numList.add(i.toString());
    }
    _numList.shuffle(Random());

    _flipped = List.filled(16, false);
    _matched = List.filled(16, false);
    _firstFlippedIndex = null;
    _score = 0;
    _matchedPairs = 0;
    _timeElapsed = 0;
    _gameOver = false;

    _startTimer();
    notifyListeners();
  }

  List<String> get numList => _numList;
  List<bool> get flipped => _flipped;
  List<bool> get matched => _matched;
  int get score => _score;
  int get timeElapsed => _timeElapsed;
  bool get gameOver => _gameOver;

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeElapsed++;
      notifyListeners();
    });
  }

  void flipCard(int index) {
    if (_flipped[index] || _matched[index] || _gameOver) return;

    if (_firstFlippedIndex == null) {
      _firstFlippedIndex = index;
      _flipped[index] = true;
    } else {
      _flipped[index] = true;
      // match successfully
      if (_numList[_firstFlippedIndex!] == _numList[index]) {
        _matched[_firstFlippedIndex!] = true;
        _matched[index] = true;
        _score += 10;
        _matchedPairs++;

        if (_matchedPairs == 8) {
          _gameOver = true;
          _timer?.cancel();
          notifyListeners();
        }
      } else {
        // match faild
        _score -= 5;
        int firstIndex = _firstFlippedIndex!;
        Future.delayed(const Duration(seconds: 1), () {
          _flipped[firstIndex] = false;
          _flipped[index] = false;
          notifyListeners();
        });
      }
      _firstFlippedIndex = null;
    }
    notifyListeners();
  }

  void resetGame() {
    _initializeGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
