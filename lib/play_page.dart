import 'package:admob_flutter/admob_flutter.dart';
import 'package:emmet_dojo/main.dart';
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
  var _textController = TextEditingController();

  // Emmet入力後の処理
  void _submission() {
    _textController.clear();
  }

  var question = ['<a href=""></a>', '<div>'];

  @override
  Widget build(BuildContext context) {
    ModeArguments modeArguments =
        ModalRoute.of(context).settings.arguments; // 選択されたモード名を引数より取得
    this.mode = modeArguments.mode;

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
            return Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 32, 8, 32),
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
                            this.question[0], // Todo クエスチョンの作成
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
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 56),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        child: TextField(
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
                    RaisedButton(
                        padding: const EdgeInsets.fromLTRB(120, 56, 120, 56),
                        child: Text(
                          'ENTER',
                          style: TextStyle(fontSize: 32),
                        ),
                        color: Colors.teal[600],
                        textColor: Colors.white,
                        onPressed: () {
                          model.add(this.mode);
                          _submission();
                        }),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Text(
                          '0 / 10',
                          style: TextStyle(fontSize: 20),
                        ))
                  ])
            ]);
          })),
    );
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
