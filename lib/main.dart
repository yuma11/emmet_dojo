import 'package:emmet_dojo/play_page.dart';
import 'package:emmet_dojo/score_model.dart';
import 'package:emmet_dojo/services/admob.dart';
import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emmet Dojo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MyHomePage(),
        '/playpage': (BuildContext context) => PlayPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScoreModel>(
      create: (_) => ScoreModel()..getScore(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Emmet Dojo'),
        ),
        body: Consumer<ScoreModel>(builder: (context, model, child) {
          return Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          _modePanel("レベル１", "html-5", "blue", context, model,
                              model.level1Score),
                          _modePanel("レベル２", "html-5", "yellow", context, model,
                              model.level2Score),
                          _modePanel("レベル３", "html-5", "red", context, model,
                              model.level3Score),
                          _modePanel("ランダム", "html-5", "green", context, model,
                              model.randomScore),
                        ],
                      ),
                    ),
                  ),
                  // Todo スコアに応じた画像の設定
                  // Container(
                  //   child: Image.asset(
                  //     './assets/images/neko01.png',
                  //     height: 120.0,
                  //     width: 120.0,
                  //   ),
                  // )
                ],
              ));
        }),
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
      ),
    );
  }

  // カードウィジェット
  //---------------------------------------
  Widget _modePanel(String modeName, String modeImg, String color,
      BuildContext context, ScoreModel model, int score) {
    String _modeName = modeName;
    Color _modeColor;
    int _modeScore = score;

    switch (color) {
      case 'blue':
        _modeColor = Color(0xFF5c6bbf);
        break;
      case 'yellow':
        _modeColor = Color(0xFFffa726);
        break;
      case 'red':
        _modeColor = Color(0xFFef5350);
        break;
      case 'green':
        _modeColor = Colors.teal[600];
        break;
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/playpage",
            arguments: ModeArguments(_modeName, _modeScore)); // プレイ画面へ
      },
      child: Card(
        margin: EdgeInsets.only(top: 24),
        child: Container(
          height: 90, // カードサイズ
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: _modeColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _modeName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      _modeName == 'ランダム'
                          ? ''
                          : _modeName == 'レベル３'
                              ? '${_modeScore.toString()} / 10'
                              : '${_modeScore.toString()} / 15',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ModeArguments {
  ModeArguments(this.mode, this.score);

  final String mode;
  final int score;
}
