import 'package:flutter/material.dart';
import 'package:osborn_digimoney/data/transactions_repository.dart';
import 'package:osborn_digimoney/model/transaction.dart';
import 'package:osborn_digimoney/views/common.dart';
import 'package:osborn_digimoney/views/success.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ussd_service/ussd_service.dart';

import 'error.dart';

// var db = DatabaseHelper();

/*makeMyRequest(BuildContext context) async {

  await PermissionHandler().requestPermissions([PermissionGroup.phone]);


  PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);

  // print("******************** " + permission.toString());

  if(permission != PermissionStatus.granted){
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
                            "Vous devez fournir les permissions nécessaires. Si ce message persiste veuillez contacter un administrateur.",
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
  } else {
    var simData = await SimService.getSimData;

    if(simData != null){
      print("***************** "+simData.cards.length.toString());
    }

    int subscriptionId = simData.cards[0].subscriptionId; // sim card subscription ID

    print("*****************   "+subscriptionId.toString());
    String code = "*137#"; // ussd code payload
    try {
      String ussdResponseMessage = await UssdService.makeRequest(subscriptionId, code);
      print("succes! message: $ussdResponseMessage");
      Navigator.of(context)
        ..push(MaterialPageRoute(
            builder: (BuildContext context) => SuccessPage(message: ussdResponseMessage,)
        ));
    } catch(e) {
      debugPrint("error! code: ${e.code} - message: ${e.message}");
      Navigator.of(context)
        ..push(MaterialPageRoute(
            builder: (BuildContext context) => ErrorPage(message: e.message,)
        ));
    }
  }

}*/

class AirtimeConfirmation extends StatefulWidget {

  AirtimeConfirmation({
    this.montant,
    this.numero,
    this.isStock,
    this.isCredit
  });

  final String montant;
  final String numero;
  final bool isStock;
  final bool isCredit;

  @override
  _AirtimeConfirmationState createState() => _AirtimeConfirmationState();
}

class _AirtimeConfirmationState extends State<AirtimeConfirmation>  {

  final TextEditingController _passController = TextEditingController();

  static const String KEY_USERNAME = "username";
  static const String KEY_SHOP = "shop";
  static const String KEY_PHONE = "phone";

  bool isCharging = false;

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
                                "images/confirmation.png",
                                color: Colors.deepOrange,
                                height: 100,
                              ),
                            ),
                          ),
                          // Message Text
                          RichText(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Form Bloc
              Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
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
                                    Icons.lock_outline,
                                    color: Colors.grey,
                                  ),
                                  Flexible(
                                    child: TextField(
                                      controller: _passController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Mot de passe",
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
                    margin: EdgeInsets.only(bottom: 20.0, right: 50.0, left: 50.0),
                    decoration: BoxDecoration(
                      //color: Theme.of(context).cardColor,
                        color: (_passController.text.length > 0) ? Colors.tealAccent : Colors.grey.withOpacity(.6),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: (_passController.text.length > 0) ? Colors.teal : Colors.grey.withOpacity(.6),
                        child: Center(
                          child: isCharging
                            ? CircularProgressIndicator()
                            : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "Envoyer",
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
                        onTap: () async {
                          if(_passController.text.length > 0){
                            setState(() {
                              isCharging = true;
                            });

                            SharedPreferences prefs = await SharedPreferences.getInstance();

                            await PermissionHandler().requestPermissions([PermissionGroup.phone]);

                            PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);

                            if(permission != PermissionStatus.granted){
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
                                                "Vous devez fournir les permissions nécessaires. Si ce message persiste veuillez contacter un administrateur.",
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
                            } else {

                              String code = widget.isStock ? "*1234#" : "*137#"; // ussd code payload
                              try {
                                String ussdResponseMessage = await UssdService.makeRequest(1, code);
                                print("succes! message: $ussdResponseMessage");

                                // Save transaction
                                int result = await TransactionRepository.insertOneTransactionInDatabase(
                                  OPTransaction(
                                    agent: prefs.getString(KEY_USERNAME),
                                    observations: ussdResponseMessage,
                                    creditOuCash: widget.isCredit ? "Crédit" : "Cash",
                                    type: "Airtime",
                                    numero: widget.numero,
                                    status: "pending",
                                    montant: widget.montant,
                                    date: DateTime.now().toString(),
                                  )
                                );

                                if(result > 0) {
                                  // Okay
                                  Navigator.of(context)
                                    ..push(MaterialPageRoute(
                                        builder: (BuildContext context) => SuccessPage()
                                    ));
                                } else {
                                  print("************** Ouups, something went wrong :(");
                                  print("************** Result = $result");
                                  Navigator.of(context)
                                    ..push(MaterialPageRoute(
                                        builder: (BuildContext context) => ErrorPage(message: "************** Ouups, something went wrong :(",)
                                    ));
                                }

                              } catch(e) {
                                debugPrint("error! code: ${e.code} - message: ${e.message}");
                                Navigator.of(context)
                                  ..push(MaterialPageRoute(
                                      builder: (BuildContext context) => ErrorPage(message: e.message,)
                                  ));
                              }
                            }
                          } else {

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
