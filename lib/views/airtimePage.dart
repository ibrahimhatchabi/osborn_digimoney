import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:osborn_digimoney/views/airtimeConfirmation.dart';
import 'package:osborn_digimoney/views/common.dart';
import 'package:osborn_digimoney/views/home.dart';

// var db = DatabaseHelper();

class AirtimePage extends StatefulWidget {

  @override
  _AirtimePageState createState() => _AirtimePageState();
}

class _AirtimePageState extends State<AirtimePage>  {
  bool isStock = false;
  bool isCredit = false;

  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

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
                  // Crédit / Stock
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Switch(
                          activeColor: Colors.tealAccent,
                          value: isCredit,
                          onChanged: (bool newValue) {
                            setState(() {
                              isCredit = newValue;
                            });
                          }
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          "Crédit",
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: isCredit ? Colors.tealAccent : Colors.white,
                              fontSize: 15.0,
                              fontFamily: 'bebas'
                          ),
                        ),
                      ),
                      Switch(
                          activeColor: Colors.tealAccent,
                          value: isStock,
                          onChanged: (bool newValue) {
                            setState(() {
                              isStock = newValue;
                            });
                          }
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          "Stock",
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: isStock ? Colors.tealAccent : Colors.white,
                              fontSize: 15.0,
                              fontFamily: 'bebas'
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              // Form Bloc
              Column(
                children: <Widget>[
                  Container(height: 100.0,),
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
                                        Icons.phone,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Flexible(
                                        child: TextField(
                                          keyboardType: TextInputType.phone,
                                          controller: _numeroController,
                                          decoration: InputDecoration.collapsed(
                                              hintText: "Numéro"
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
                          margin: EdgeInsets.only(top: 40.0,bottom: 20.0, right: 50.0, left: 50.0),
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
                                    Icon(
                                      Icons.attach_money,
                                      color: Colors.grey,
                                    ),
                                    Flexible(
                                      child: TextField(
                                        controller: _montantController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration.collapsed(
                                          hintText: "Montant",
                                        ),
                                        style: TextStyle(
                                          fontFamily: "LiberationSerif",
                                          color: Colors.black,
                                        ),
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
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: height - 580,bottom: 20.0, right: 50.0, left: 50.0),
                    decoration: BoxDecoration(
                      //color: Theme.of(context).cardColor,
                        color: (_montantController.text.length > 0 && _numeroController.text.length > 0) ? Colors.tealAccent : Colors.grey.withOpacity(.6),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: (_montantController.text.length > 0 && _numeroController.text.length > 0) ? Colors.teal : Colors.grey.withOpacity(.6),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "Continuer",
                                style: TextStyle(
                                    fontFamily: "bebas",
                                    letterSpacing: 1.0,
                                    color: const Color(0xFF353535).withOpacity(.6),
                                    fontSize: 20.0
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 35,
                                color: const Color(0xFF353535).withOpacity(.6),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          if(_montantController.text.length > 0 && _numeroController.text.length > 0){
                            Navigator.of(context)
                              ..push(MaterialPageRoute(
                                  builder: (BuildContext context) => AirtimeConfirmation(
                                    isCredit: isCredit,
                                    isStock: isStock,
                                    montant: _montantController.text,
                                    numero: _numeroController.text,
                                  )
                              ));
                          } else {
                            /*Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) => Scaffold(
                                            backgroundColor: Colors.blue,
                                            appBar: AppBar(
                                              backgroundColor: Colors.transparent,
                                              elevation: 0.0,
                                              automaticallyImplyLeading: false,
                                              title: Center(
                                                  child: Image.asset(
                                                    "images/osborn-text.png",
                                                    color: Colors.white,
                                                  )
                                              ),
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
                                                            "Veuillez saisir le nom d'utilisateur dans le champs DAS !!!",
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
                                    ));*/
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
