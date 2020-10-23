import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {

  static const String KEY_USERNAME = "username";
  static const String KEY_SHOP = "shop";
  static const String KEY_PHONE = "phone";
  static const String KEY_ADRESSE = "adresse";
  static const String KEY_FONCTION = "fonction";

  SharedPreferences prefs;

  Future<bool> getLocalPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF2584fc),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2584fc),
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context);
          }),
        title: Text('Mon profile'),
        centerTitle: true,
      ),
      body: FutureBuilder<bool>(
        future: this.getLocalPrefs(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Container(
              width: width,
                height: height,
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      // Avatar container
                      Positioned(
                        top: 0,
                        child: Container(
                          color: Colors.white,
                          width: width,
                          height: height / 2.5,
                          child: Image.asset(
                            'images/avatar.png',
                          ),
                        ),
                      ),
                      // Intels container
                      Positioned(
                        top: 200,
                        child: Padding(
                          padding: EdgeInsets.only(left: (width * 10) / 100),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  blurRadius: 2,
                                  spreadRadius: 2
                                )
                              ]
                            ),
                            height: 300,
                            width: (width * 80) / 100,
                            child: Padding(
                              padding: EdgeInsets.only(left:(width * 20) / 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15.0),
                                        child: Icon(
                                          FontAwesomeIcons.addressBook,
                                          color: Color(0xff476cfb),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Nom complet',
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 18.0,
                                                )),
                                            Text(prefs.getString(KEY_USERNAME),
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15.0),
                                        child: Icon(
                                          FontAwesomeIcons.phone,
                                          color: Color(0xff476cfb),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Télephone',
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 18.0,
                                              )
                                            ),
                                            Text(prefs.getString(KEY_PHONE),
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15.0),
                                        child: Icon(
                                          FontAwesomeIcons.laptop,
                                          color: Color(0xff476cfb),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Fonction',
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 18.0,
                                              )),
                                            Text(prefs.getString(KEY_FONCTION),
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15.0),
                                        child: Icon(
                                          FontAwesomeIcons.home,
                                          color: Color(0xff476cfb),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 80.0),
                                              child: Text('Adresse',
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 18.0,
                                                )),
                                            ),
                                            Text(prefs.getString(KEY_ADRESSE),
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          }
          return ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(50.0),
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Veuillez patienter",
                            style: TextStyle(
                              fontFamily: "bebas",
                              letterSpacing: 1.0,
                              color: const Color(0xFF353535).withOpacity(.6),
                              fontSize: 20.0
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
          );
        },
      )
    );
  }
}
