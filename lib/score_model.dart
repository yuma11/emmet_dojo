import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Score {
  final int score;

  Score(this.score);
}

class ScoreModel extends ChangeNotifier {
  int score = 0;

  void getScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.score = prefs.getInt('counter');

    print("h");
    notifyListeners();
  }

  void add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.score = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', this.score);
    print(this.score);
    notifyListeners();
  }
}
