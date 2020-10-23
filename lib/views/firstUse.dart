import 'package:flutter/material.dart';
import 'package:osborn_digimoney/data/transactions_repository.dart';
import 'package:osborn_digimoney/views/common.dart';
import 'package:osborn_digimoney/views/login.dart';
import 'package:flutter_offline/flutter_offline.dart';

class FirstUse extends StatefulWidget {
  @override
  _FirstUseState createState() => _FirstUseState();
}

class _FirstUseState extends State<FirstUse> with SingleTickerProviderStateMixin{
  Animation animation, delayedAnimation1, delayedAnimation2, delayedAnimation3;
  AnimationController animationController;
  bool isDasObscure = true;
  bool isPassWordObscure = true;
  bool isCharging = false;

  static const String KEY_IS_FIRST_USE = "is_first_use";

  String dropdownValue = 'Place Toumo';

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ){
              final bool connected = connectivity != ConnectivityResult.none;
              return Container(
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
                            SizedBox(height: 50.0,),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Bienvenue",
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontFamily: 'bebas'
                                    ),
                                  ),
                                  Text(
                                    "Veuillez choisir votre boutique",
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
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(right:5.0),
                                                child: Icon(
                                                    Icons.location_city,
                                                    color: Colors.grey
                                                ),
                                              ),
                                              DropdownButton<String>(
                                                underline: Container(
                                                  height: 0,
                                                  color: Colors.transparent,
                                                ),
                                                value: dropdownValue,
                                                elevation: 0,
                                                style: TextStyle(
                                                    letterSpacing: 1.0,
                                                    color: Colors.grey,
                                                    fontSize: 20.0,
                                                    fontFamily: 'bebas'
                                                ),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    dropdownValue = newValue;
                                                  });
                                                },
                                                items: <String>['Place Toumo', 'Terrain Musulman', 'Harobanda', 'Katako','Katako1','Katako2','Katako3','Katako4','Katako5',]
                                                    .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Container(
                                                      //color: Colors.yellow,
                                                        width: width - 180,
                                                        child: Text(value)
                                                    ),
                                                  );
                                                })
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Button continuer
                            Container(
                              height: 50.0,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 80.0,bottom: 20.0, right: 50.0, left: 50.0),
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
                                    child: isCharging
                                      ? CircularProgressIndicator()
                                      : Text(
                                      "Continuer",
                                      style: TextStyle(
                                          fontFamily: "bebas",
                                          letterSpacing: 1.0,
                                          color: const Color(0xFF353535).withOpacity(.6),
                                          fontSize: 20.0
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    if(connected){
                                      setState(() {
                                        isCharging = true;
                                      });
                                      await TransactionRepository.initUsers(dropdownValue).then(
                                        (value){
                                          Navigator.of(context)
                                            ..pop()
                                            ..push(MaterialPageRoute(
                                              builder: (
                                                BuildContext context) =>
                                                Login(
                                                  shopName: dropdownValue,
                                                )
                                            ));
                                        }
                                      );


                                    } else {
                                      Navigator.push(context, myNetworkErrorPopup());
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Text(
              "The child"
            ),
          ),
        );
      });
  }
}


