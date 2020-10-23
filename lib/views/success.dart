import 'package:flutter/material.dart';

import 'package:osborn_digimoney/views/common.dart';
import 'package:osborn_digimoney/views/home.dart';

import 'airtimePage.dart';

class SuccessPage extends StatefulWidget {

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {


  double actionButtonHeight = 70.0;
  double actionButtonIconHeight = 35.0;
  double actionButtonFontSize = 12.0;
  Color actionButtonTextColor = const Color(0xFF353535).withOpacity(.6);
  Color actionButtonColor = Colors.white.withOpacity(.8);
  Color mainTextColor = const Color(0xFF353535).withOpacity(.6);

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

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
          child: ListView(
            children: <Widget>[
              // Page Title
              Column(
                children: <Widget>[
                  SizedBox(height: 30.0,),
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:5.0),
                          child: Image.asset(
                            "images/airtime.png",
                            color: Colors.white,
                            height: 18,
                          )
                        ),
                        Text(
                          "Airtime",
                          style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'bebas'
                          ),
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              // Message Container
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left:50.0,right: 50.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          // Message logo
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 0, bottom: 30),
                              child: Image.asset(
                                "images/succes.png",
                                color: Colors.lightGreenAccent,
                                height: 100,
                              ),
                            ),
                          ),
                          // Message Text
                          /*RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Vous êtes sur le point d'envoyer ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  //fontFamily: 'bebas'
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: ' Airtime ${widget.montant} FCFA',
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      //fontFamily: 'bebas'
                                    ),
                                  ),
                                  TextSpan(text: ' au',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      //fontFamily: 'bebas'
                                    ),
                                  ),
                                  TextSpan(text: ' ${widget.numero}',
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 18,
                                      //fontWeight: FontWeight.bold,
                                      //fontFamily: 'bebas'
                                    ),
                                  ),
                                  TextSpan(text: '. Entrez votre mot de passe pour confirmer la trasaction.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      //fontFamily: 'bebas'
                                    ),
                                  )
                                ]
                            ),
                          ),*/
                          Text(
                            "Opération effectuée avec succès !!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              //fontFamily: 'bebas'
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Action buttons
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 50),
                  width: width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Airtime
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: actionButtonColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 3.0,
                              blurRadius: 10.0,
                            ),
                          ]
                        ),
                        // margin: const EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                            width: width / 6,
                            height: actionButtonHeight,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: actionButtonTextColor,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.black87,
                                onTap: () {
                                  Navigator.of(context)
                                    ..pop()
                                    ..push(MaterialPageRoute(
                                        builder: (BuildContext context) => AirtimePage()
                                    ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Image.asset(
                                      "images/airtime.png",
                                      height: actionButtonIconHeight,
                                      color: actionButtonTextColor,
                                    ),
                                    Text(
                                      "Airtime",
                                      style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: actionButtonTextColor,
                                        // color: mainTextColor,
                                        fontSize: actionButtonFontSize,
                                        fontFamily: 'bebas'
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),
                      ),
                      // Accueil
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: actionButtonColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 3.0,
                              blurRadius: 10.0,
                            ),
                          ]
                        ),
                        // margin: const EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          width: width / 6,
                          height: actionButtonHeight,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: actionButtonTextColor,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.black87,
                              onTap: () {
                                Navigator.of(context)
                                  ..pop()
                                  ..push(MaterialPageRoute(
                                      builder: (BuildContext context) => HomePage()
                                  ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Image.asset(
                                    "images/airtime.png",
                                    height: actionButtonIconHeight,
                                    color: actionButtonTextColor,
                                  ),
                                  Text(
                                    "Accueil",
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: actionButtonTextColor,
                                      // color: mainTextColor,
                                      fontSize: actionButtonFontSize,
                                      fontFamily: 'bebas'
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
