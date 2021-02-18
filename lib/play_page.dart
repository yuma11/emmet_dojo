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

  @override
  Widget build(BuildContext context) {
    // 選択されたモード名を引数より取得
    this.mode = ModalRoute.of(context).settings.arguments;
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
              Text(
                model.score.toString(),
                style: TextStyle(fontSize: 100.0),
              ),
              RaisedButton(
                  child: Text('おしてね'),
                  onPressed: () {
                    model.add();
                  })
            ]);
          })),
    );
  }
}
