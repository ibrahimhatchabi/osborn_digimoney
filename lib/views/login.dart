import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:osborn_digimoney/views/common.dart';
import 'package:osborn_digimoney/views/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

// var db = DatabaseHelper();
final databaseReference = Firestore.instance;
class Login extends StatefulWidget {

  Login({Key key, this.shopName}) : super(key: key);

  final String shopName;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation1, delayedAnimation2, delayedAnimation3;
  AnimationController animationController;
  bool isDasObscure = true;
  bool isPassWordObscure = true;
  bool error = false;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  static const String KEY_USERNAME = "username";
  static const String KEY_SHOP = "shop";
  static const String KEY_PHONE = "phone";
  static const String KEY_ADRESSE = "adresse";
  static const String KEY_FONCTION = "fonction";

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn
    ));

    delayedAnimation1 = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.4, 1.0, curve: Curves.fastOutSlowIn)
      )
    );

    delayedAnimation2 = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn)
        )
    );

    delayedAnimation3 = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.6, 1.0, curve: Curves.elasticInOut)
        )
    );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
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
                  // Business Logo
                  Transform(
                    transform: Matrix4.translationValues(0.0, animation.value * height, 0.0 ),
                    child: Container(
                      margin: EdgeInsets.only(top: 50.0),
                      width: 150.0,
                      height: 120.0,
                      child: Center(
                        child: Image.asset(
                          "images/osborn-digimoney.png",
                          color: Colors.white,
                        )
                      ),
                    ),
                  ),
                  // Page Title
                  Transform(
                    transform: Matrix4.translationValues(0.0, delayedAnimation1.value * height, 0.0 ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 80.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right:5.0),
                              child: Icon(
                                Icons.person_outline,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Authentification",
                              style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: 'bebas'
                              ),
                            ),
                          ]
                        ),
                      ],
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(0.0, delayedAnimation2.value * height, 0.0 ),
                    child: Column(
                      children: <Widget>[
                        Container(height: 20.0,),
                        Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 20.0, right: 50.0, left: 50.0, ),
                                decoration: BoxDecoration(
                                  //color: Theme.of(context).cardColor,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(2.0))
                                ),
                                child: IconTheme(
                                  data: IconThemeData(
                                      color: Theme.of(context).accentColor
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 9.0,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(right:5.0),
                                          child: Icon(
                                            Icons.person,
                                              color: this.error ? Colors.red : Colors.grey
                                          ),
                                        ),
                                        Flexible(
                                          child: TextField(
                                            onTap: (){
                                              setState(() {
                                                this.error = false;
                                              });
                                            },
                                            controller: _textController,
                                            decoration: InputDecoration.collapsed(
                                                hintText: "Identifiant"
                                            ),
                                            style: TextStyle(
                                              fontFamily: "LiberationSerif",
                                              color: Colors.black,
                                            ),
                                            obscureText: false,
                                          )
                                        ),
                                        SizedBox(
                                          height: 40.0,
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20.0,bottom: 20.0, right: 50.0, left: 50.0),
                                decoration: BoxDecoration(
                                  //color: Theme.of(context).cardColor,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(2.0))
                                ),
                                child: IconTheme(
                                  data: IconThemeData(
                                      color: Theme.of(context).accentColor
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 9.0,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(right:5.0),
                                          child: Icon(
                                              Icons.security,
                                              color: this.error ? Colors.red : Colors.grey
                                          ),
                                        ),
                                        Flexible(
                                          child: TextField(
                                            onTap: (){
                                              setState(() {
                                                this.error = false;
                                              });
                                            },
                                            controller: _passwordController,
                                            decoration: InputDecoration.collapsed(
                                              hintText: "Mot de passe ",
                                            ),
                                            style: TextStyle(
                                              fontFamily: "LiberationSerif",
                                              color: Colors.black,
                                            ),
                                            obscureText: isPassWordObscure,
                                          ),
                                        ),
                                        Container(
                                          child: InkWell(
                                            child: Container(
                                              child: Icon(
                                                Icons.remove_red_eye,
                                                color: isPassWordObscure ? Colors.grey : Colors.blue,
                                              ),
                                              height: 40.0,
                                            ),
                                            onTap: (){
                                              setState(() {
                                                if(isPassWordObscure){
                                                  isPassWordObscure = false;
                                                } else{
                                                  isPassWordObscure = true;
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                              )
                            ],
                          ),
                        ),
                        /*Container(
                          child: this.error
                            ? Center(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 1
                                  )
                                ),
                                child: Text(
                                    "Veuillez vous identifier",
                                    style: TextStyle(
                                      fontFamily: "bebas",
                                      letterSpacing: 1.0,
                                      color: Colors.red,
                                      fontSize: 20.0
                                    ),
                                  ),
                              ),
                              )
                            : null,
                        ),*/
                        Container(
                          height: 50.0,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 20.0,bottom: 20.0, right: 50.0, left: 50.0),
                          decoration: BoxDecoration(
                            //color: Theme.of(context).cardColor,
                              color: Colors.tealAccent,
                              borderRadius: BorderRadius.all(Radius.circular(4.0))
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.teal,
                              child: Center(
                                child: Text(
                                  "Se connecter",
                                  style: TextStyle(
                                    fontFamily: "bebas",
                                    letterSpacing: 1.0,
                                    color: const Color(0xFF353535).withOpacity(.6),
                                    fontSize: 20.0
                                  ),
                                ),
                              ),
                              onTap: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  if(_textController.text.length > 0 && _passwordController.text.length > 0){
                                  await databaseReference
                                    .collection("users")
                                    .getDocuments(source: Source.cache)
                                    .then((QuerySnapshot snapshot) {
                                      for(final user in snapshot.documents) {
                                        print('${user.data}}');
                                        if (user.data["identifiant"] !=
                                            _textController.text ||
                                            user.data["password"] !=
                                                _passwordController.text) {

                                        } else {
                                          prefs.setString(KEY_USERNAME, user.data["prenom"]+" "+user.data["nom"]);
                                          prefs.setString(KEY_SHOP, user.data["shop"]);
                                          prefs.setString(KEY_PHONE, user.data["telephone"]);
                                          prefs.setString(KEY_FONCTION, user.data["fonction"]);
                                          prefs.setString(KEY_ADRESSE, user.data["adresse"]);

                                          Navigator.of(context)
                                            ..push(MaterialPageRoute(
                                                builder: (BuildContext context) => HomePage()
                                            ));
                                          break;
                                        }
                                        _textController.clear();
                                        _passwordController.clear();
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (BuildContext context) => Scaffold(
                                                backgroundColor: const Color(0xFF2584fc),
                                                appBar: AppBar(
                                                  backgroundColor: const Color(0xFF2584fc),
                                                  elevation: 0,
                                                  leading: null,
                                                  title: Image.asset(
                                                    "images/osborn-text.png",
                                                    color: Colors.white,
                                                    height: 30,
                                                  ),
                                                  centerTitle: true,
                                                ),
                                                body: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      AlertDialog(
                                                        title: Text("Erreur"),
                                                        content: SingleChildScrollView(
                                                          child: ListBody(
                                                            children: <Widget>[
                                                              Text(
                                                                "Iditifiant ou mot de passe incorrect. Veuillez réessayer !!!",
                                                                //style: _myAlertDialogTextStyle,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text(
                                                              "OK",
                                                              //style: _myAlertDialogTextStyle,
                                                            ),
                                                            onPressed: () {
                                                              //exit(0);
                                                              Navigator.of(context)
                                                                ..pop();
                                                            },
                                                          )
                                                        ],
                                                      )
                                                    ]
                                                )
                                            )
                                        ));
                                      }
                                    });
                                } else {
                                  setState(() {
                                    this.error = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height - 610.0 ,
                  ),
                  /*Transform(
                    transform: Matrix4.translationValues(0.0, delayedAnimation3.value * height, 0.0 ),
                    child: Container(
                     margin: EdgeInsets.only(bottom: 10.0),
                      width: 60.0,
                      height: 30.0,
                      child: Center(
                        child: Text(
                          "By Digitaliita",
                          style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'bebas'
                          ),
                        ),
                      )
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        );
      });
  }
}
