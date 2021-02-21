import 'package:admob_flutter/admob_flutter.dart';
import 'dart:math' as math;
import 'package:emmet_dojo/main.dart';
import 'package:emmet_dojo/question.dart';
import 'package:emmet_dojo/score_model.dart';
import 'package:emmet_dojo/services/admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => new _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  String mode;
  int index = 0;
  int currentIndex = 1;
  int correctAnswer = 0;
  int backRandIndex = 0;
  int randIndex = 0;
  bool isTextFieldEnabled = true;
  var _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ModeArguments modeArguments =
        ModalRoute.of(context).settings.arguments; // 選択されたモード名を引数より取得
    this.mode = modeArguments.mode;

    Question question = Question(this.mode); // Todo

    void nextRandomQuestion() {
      var rand = math.Random();
      this.randIndex = rand.nextInt(40);
      question.randomQuestion(this.index, this.randIndex);
    }

    // Emmet入力後の処理
    void _submission(int index, ScoreModel model) async {
      bool isCorrect = question.checkTheAnswer(
          this.mode, index, _textController.text, randIndex);

      // 正解であれば正解数をプラス
      if (isCorrect) {
        this.correctAnswer++;
      }

      // 問題数が15未満の時
      if (currentIndex < question.returnQuestionLength(this.mode)) {
        _showDialog(
            isCorrect,
            false,
            question.printAnswer(this.mode, this.index,
                this.randIndex)); // _showDialog(正誤判定, 終了判定, 答えのEmmet)
        nextRandomQuestion();
        this.index++;
        this.currentIndex++;
        // 問題数が15以上の時
      } else {
        model.add(this.mode, this.correctAnswer);
        _showDialog(
            isCorrect,
            true,
            question.printAnswer(this.mode, this.index,
                this.randIndex)); // _showDialog(正誤判定, 終了判定, 答えのEmmet)
        this.isTextFieldEnabled = false;
      }
      setState(() {
        // this.isTextFieldEnabled = false;
      });
      _textController.clear();
    }

    return ChangeNotifierProvider<ScoreModel>(
      create: (_) => ScoreModel()..getScore(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(this.mode),
          ),
          bottomNavigationBar: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              AdmobBanner(
                adUnitId: AdMobService().getBannerAdUnitId(),
                adSize: AdmobBannerSize(
                  width: MediaQuery.of(context).size.width.toInt(),
                  height: AdMobService().getHeight(context).toInt(),
                  name: 'SMART_BANNER',
                ),
              ),
            ],
          ),
          body: Consumer<ScoreModel>(builder: (context, model, child) {
            return SingleChildScrollView(
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(16),
                          height: 300,
                          width: MediaQuery.of(context).size.width - 16,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.teal[600],
                              width: 6,
                            ),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              this.mode == 'ランダム'
                                  ? question.randomQuestion(
                                      this.index, this.randIndex)
                                  : question.printQuestion(
                                      this.mode, this.index), // Todo クエスチョンの作成
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        )
                      ]),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 32,
                          child: TextField(
                            //Todo
                            enabled: this.isTextFieldEnabled,
                            controller: _textController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.text_fields),
                              hintText: 'Emmetを入力してください',
                              labelText: 'Emmet',
                            ),
                          ),
                        ),
                      )
                      //returnModeScore(this.mode, model), // Todo 確認用
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width - 32,
                        child: RaisedButton(
                            padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
                            child: Text(
                              'ENTER',
                              style: TextStyle(fontSize: 28),
                            ),
                            color: Colors.teal[600],
                            textColor: Colors.white,
                            onPressed: () {
                              // model.add(this.mode);
                              _submission(this.index, model);
                            }),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: Text(
                            this.mode == 'レベル３'
                                ? '${this.currentIndex} / 10'
                                : '${this.currentIndex} / 15',
                            style: TextStyle(fontSize: 20),
                          ))
                    ])
              ]),
            );
          })),
    );
  }

  Future _showDialog(bool isCorrect, bool isEnd, String answer) async {
    if (isEnd) {
      var value1 = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('終了'),
          content: this.mode == 'レベル３'
              ? Text('お疲れ様でした。\n正答率：${this.correctAnswer}/10')
              : Text('お疲れ様でした。\n正答率：${this.correctAnswer}/15'),
          actions: <Widget>[
            // Todo
            SimpleDialogOption(
              child: Center(child: Text('トップへ')),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/", (_) => false);
              },
            ),
          ],
        ),
      );
    } else {
      var value2 = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: isCorrect ? Text('正解！') : Text('不正解...'),
          content: isCorrect ? Text('その調子！') : Text('正解は「${answer}」です。'),
        ),
      );
    }
  }
}

// モード選択によって表示するスコア値の変更
Widget returnModeScore(String mode, ScoreModel model) {
  switch (mode) {
    case 'レベル１':
      return Text(
        model.level1Score.toString(),
        style: TextStyle(fontSize: 100.0),
      );
      break;
    case 'レベル２':
      return Text(
        model.level2Score.toString(),
        style: TextStyle(fontSize: 100.0),
      );
      break;
    case 'レベル３':
      return Text(
        model.level3Score.toString(),
        style: TextStyle(fontSize: 100.0),
      );
      break;
    case 'ランダム':
      return Text(
        model.randomScore.toString(),
        style: TextStyle(fontSize: 100.0),
      );
      break;
    default:
      return null;
      break;
  }
}
