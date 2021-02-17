import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget {
  final String language;
  PlayPage({Key key, @required this.language}) : super(key: key);
  @override
  _PlayPageState createState() => new _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('レベル１'),
      ),
    );
  }
}
