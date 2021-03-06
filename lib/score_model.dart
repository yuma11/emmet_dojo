import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Score {
  final int score;

  Score(this.score);
}

class ScoreModel extends ChangeNotifier {
  int score = 0;
  int level1Score = 0;
  int level2Score = 0;
  int level3Score = 0;
  int randomScore = 0;

  void getScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.score = prefs.getInt('counter');
    this.level1Score = prefs.getInt('レベル１') ?? 0;
    this.level2Score = prefs.getInt('レベル２') ?? 0;
    this.level3Score = prefs.getInt('レベル３') ?? 0;
    this.randomScore = prefs.getInt('ランダム') ?? 0;
    notifyListeners();
  }

  void add(String mode, int correctAnswer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (mode) {
      case 'レベル１':
        if (prefs.getInt(mode) == null) {
          this.level1Score = correctAnswer;
          await prefs.setInt(mode, this.level1Score);
        } else if (correctAnswer > prefs.getInt(mode)) {
          this.level1Score = correctAnswer;
          await prefs.setInt(mode, this.level1Score);
        }
        break;
      case 'レベル２':
        if (prefs.getInt(mode) == null) {
          this.level2Score = correctAnswer;
          await prefs.setInt(mode, this.level2Score);
        } else if (correctAnswer > prefs.getInt(mode)) {
          this.level2Score = correctAnswer;
          await prefs.setInt(mode, this.level2Score);
        }
        break;
      case 'レベル３':
        if (prefs.getInt(mode) == null) {
          this.level3Score = correctAnswer;
          await prefs.setInt(mode, this.level3Score);
        } else if (correctAnswer > prefs.getInt(mode)) {
          this.level3Score = correctAnswer;
          await prefs.setInt(mode, this.level3Score);
        }
        break;
      case 'ランダム':
        this.randomScore = (prefs.getInt(mode) ?? 0) + 1;
        await prefs.setInt(mode, this.randomScore);
        break;
    }
    notifyListeners();
  }
}
