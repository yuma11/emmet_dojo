import 'package:emmet_dojo/main.dart';
import 'package:emmet_dojo/score_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => new _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  String mode;
  int _score;

  void _incrementScore() {
    // ➃変数の値を変更する際、setStateを必ず呼ぶ必要がある
    setState(() => _score++);
  }

  @override
  Widget build(BuildContext context) {
    ModeArguments modeArguments =
        ModalRoute.of(context).settings.arguments; // 選択されたモード名を引数より取得
    this.mode = modeArguments.mode;
    this._score = modeArguments.score;

    return ChangeNotifierProvider<ScoreModel>(
      create: (_) => ScoreModel()..getScore(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(this.mode),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  "/", (_) => false) // プッシュされたルート下にある全てのルートを削除した後、ホーム画面を表示
              ),
          body: Consumer<ScoreModel>(builder: (context, model, child) {
            return Column(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    returnModeScore(this.mode, model),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        child: Text('PUSH'),
                        onPressed: () {
                          model.add(this.mode);
                        }),
                  ])
            ]);
          })),
    );
  }
}

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
