import 'package:flutter/material.dart';
import 'package:osborn_digimoney/views/firstUse.dart';
import 'package:osborn_digimoney/views/login.dart';

import 'data/database.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  var db = OperationsDatabase();

  bool isFirstUse = await db.isFirstUse();

  print("************* $isFirstUse");

  runApp(MyApp(isFirstUse: isFirstUse,));
}

class MyApp extends StatefulWidget {
  final bool isFirstUse;

  MyApp({Key key, this.isFirstUse}) : super(key: key);

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Osborn Digimoney',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.lightBlue
      ),
      home: widget.isFirstUse ? FirstUse() : Login(),
    );
  }
}
