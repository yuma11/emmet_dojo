import 'package:emmet_dojo/services/admob.dart';
import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emmet Dojo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Emmet Dojo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lists = [
      _modePanel("レベル１", "html-5", "blue", context),
      _modePanel("レベル２", "html-5", "yellow", context),
      _modePanel("レベル３", "html-5", "red", context),
      _modePanel("ランダム", "html-5", "green", context),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: lists,
                ),
              ),
              // Todo
              Container(
                child: Image.asset(
                  './assets/images/neko01.png',
                  height: 150.0,
                  width: 150.0,
                ),
              )
            ],
          )),
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
          // BottomNavigationBar(
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.home),
          //       label: '',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.list),
          //       label: '',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.person),
          //       label: '',
          //     ),
          //   ],
          //   currentIndex: _selectedIndex,
          //   onTap: _onItemTapped,
          // ),
        ],
      ),
    );
  }

  // カードウィジェット
  //---------------------------------------
  Widget _modePanel(
      String modeName, String modeImg, String color, BuildContext context) {
    var _modeName = modeName;
    var _modeImg = "assets/images/" + modeImg + ".svg";
    var _modeColor;

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
        // Todo
        print('Push!');
      },
      child: Card(
        margin: EdgeInsets.only(top: 32),
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
                      '達成率：0/10',
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
