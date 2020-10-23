import 'package:flutter/material.dart';

import 'package:osborn_digimoney/views/common.dart';

class ErrorPage extends StatefulWidget {

  ErrorPage({Key key, this.message}) : super(key: key);

  final String message;

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF2584fc),
                const Color(0xFF137bff),
                const Color(0xFF0262db)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Center(
            child: Text(
              widget.message,
              style: TextStyle(
                  letterSpacing: .5,
                  color: Colors.red,
                  fontSize: 25.0,
                  fontFamily: 'bebas'
              ),
            )
        ),
      ),
    );
  }
}
