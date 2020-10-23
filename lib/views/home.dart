import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:osborn_digimoney/data/transactions_repository.dart';
import 'package:osborn_digimoney/model/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'package:osborn_digimoney/views/airtimePage.dart';
import 'package:osborn_digimoney/views/common.dart';


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



class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation1, delayedAnimation2, delayedAnimation3;
  AnimationController animationController;

  List<OPTransaction> transactions = [];

  double tableRowHeight = 10.0;
  double actionButtonHeight = 70.0;
  double actionButtonIconHeight = 35.0;
  double actionButtonFontSize = 12.0;
//    Color actionButtonTextColor = const Color(0xFF2584fc);
  Color actionButtonTextColor = const Color(0xFF353535).withOpacity(.6);
  Color actionButtonColor = Colors.white.withOpacity(.8);
  Color mainTextColor = const Color(0xFF353535).withOpacity(.6);

  static const String KEY_USERNAME = "username";
  static const String KEY_SHOP = "shop";
  static const String KEY_PHONE = "phone";

  SharedPreferences prefs;

  bool isCharging = false;

  Future<List<TableRow>> fetchTransactions() async {

    prefs = await SharedPreferences.getInstance();

    transactions = await TransactionRepository.getTransactionsFromDatabase();

    List<TableRow> recupTtransactions = List<TableRow>();

    // Add table header
    recupTtransactions.add(TableRow(
        children: <Widget>[
          FittedBox(
            fit: BoxFit.contain,
            child: Container(
              color: mainTextColor,
              width: 50.0,
              height: tableRowHeight,
              padding: EdgeInsets.all(2),
              child: Center(
                child: Text(
                  "Numero",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 7.0,
                      fontFamily: "bebas"
                  ),
                ),
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Container(
              color: mainTextColor,
              width: 50.0,
              height: tableRowHeight,
              padding: EdgeInsets.all(2),
              child: Center(
                child: Text(
                  "Montant",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 7.0,
                      fontFamily: "bebas"
                  ),
                ),
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Container(
              color: mainTextColor,
              width: 50.0,
              height: tableRowHeight,
              padding: EdgeInsets.all(2),
              child: Center(
                child: Text(
                  "Date et heure",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 7.0,
                      fontFamily: "bebas"
                  ),
                ),
              ),
            ),
          ),
        ]
    ));

    if(transactions.length > 0){
      for (final item in transactions.reversed) {
        if(recupTtransactions.length < 5) {
          recupTtransactions.add(
            TableRow(
                children: <Widget>[
                  // Numero Column
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      width: 50.0,
                      height: tableRowHeight,
                      padding: EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          item.numero,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: mainTextColor,
                              fontSize: 6.0,
                              fontFamily: "bebas"
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Montant Column
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      width: 50.0,
                      height: tableRowHeight,
                      padding: EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          item.montant + ' ' + item.status,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: mainTextColor,
                              fontSize: 6.0,
                              fontFamily: "bebas"
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Date Column
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      width: 50.0,
                      height: tableRowHeight,
                      padding: EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(item.date)),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: mainTextColor,
                              fontSize: 6.0,
                              fontFamily: "bebas"
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          );
        }
      }
    } else {
      recupTtransactions.add(
        TableRow(
          children: <Widget>[
            // Numero Column
            FittedBox(
              fit: BoxFit.contain,
              child: Container(
                width: 50.0,
                height: tableRowHeight,
                padding: EdgeInsets.all(2),
                child: Center(
                  child: null,
                ),
              ),
            ),
            // Montant Column
            FittedBox(
              fit: BoxFit.contain,
              child: Container(
                width: 50.0,
                height: 20,
                padding: EdgeInsets.all(2),
                child: Center(
                  child: Text(
                    "Aucune opération",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: mainTextColor,
                      fontSize: 6.0,
                      fontFamily: "bebas"
                    ),
                  ),
                ),
              ),
            ),
            // Date Column
            FittedBox(
              fit: BoxFit.contain,
              child: Container(
                width: 50.0,
                height: tableRowHeight,
                padding: EdgeInsets.all(2),
                child: Center(
                  child: null
                ),
              ),
            ),
          ]
        ),
      );
    }
    return recupTtransactions;
  }

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

    return  Form(
      onWillPop: (){
        return Future<bool>.value(false);
      },
      child: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ){
          final bool connected = connectivity != ConnectivityResult.none;
          return AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              return FutureBuilder(
                future: fetchTransactions(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (snapshot.hasData) {
                    return Scaffold(
                      appBar: myAppBar(context),
                      body: Material(
                        child: Container(
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
                            child: Stack(
                              children: <Widget>[
                                // Page Title
                                Transform(
                                  transform: Matrix4.translationValues(0.0, animation.value * height, 0.0 ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 30.0,),
                                      Padding(
                                        padding: const EdgeInsets.only(left:20.0, right: 20.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Text
                                            Container(
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(right:5.0),
                                                      child: Icon(
                                                        Icons.dashboard,
                                                        size: 20.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Tableau de bord",
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
                                            // Bckup Icon
                                            isCharging
                                              ? CircularProgressIndicator()
                                              : IconButton(
                                              icon: Icon(
                                                Icons.backup
                                              ),
                                              color: connected ? Colors.green : Colors.grey,
                                              onPressed: () async {
                                                if(connected) {
                                                  setState(() {
                                                    isCharging = true;
                                                  });
                                                  var transactions = await TransactionRepository.getLatestTransactionsFromDatabase();
                                                  await TransactionRepository.backUpTrasactions(transactions);
                                                  setState(() {
                                                    isCharging = false;
                                                  });
                                                } else {
                                                  Navigator.push(context, myNetworkErrorPopup());
                                                }
                                              },
                                            )
                                          ]
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Dashboard
                                Positioned(
                                  top: 50,
                                  child: Transform(
                                    transform: Matrix4.translationValues(0.0, delayedAnimation1.value * height, 0.0 ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(height: 20.0,),
                                        Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                                                child: Container(
                                                  width: width - 40.0,
                                                  height: 280,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(255, 255, 255, .8),
                                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            // Date
                                                            Container(
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(right:5.0),
                                                                    child: Icon(
                                                                      Icons.calendar_today,
                                                                      color: mainTextColor,
                                                                      size: 16,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                                                    style: TextStyle(
                                                                        letterSpacing: 1.0,
                                                                        color: mainTextColor,
                                                                        fontSize: 15.0,
                                                                        fontFamily: 'bebas'
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Shop adress
                                                            Container(
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(right:5.0),
                                                                    child: Icon(
                                                                      Icons.domain,
                                                                      color: mainTextColor,
                                                                      size: 16,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    prefs.getString(KEY_SHOP),
                                                                    style: TextStyle(
                                                                        letterSpacing: 1.0,
                                                                        color: mainTextColor,
                                                                        fontSize: 15.0,
                                                                        fontFamily: 'bebas'
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        // User full name
                                                        Padding(
                                                          padding: const EdgeInsets.only(top:10.0),
                                                          child: Container(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right:5.0),
                                                                  child: Icon(
                                                                    Icons.assignment_ind,
                                                                    color: mainTextColor,
                                                                    size: 35,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  prefs.getString(KEY_USERNAME),
                                                                  style: TextStyle(
                                                                    letterSpacing: 1.0,
                                                                    color: mainTextColor,
                                                                    fontSize: 25.0,
                                                                    fontFamily: 'bebas'
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // Title bloc operations
                                                        Padding(
                                                          padding: const EdgeInsets.only(top:10.0),
                                                          child: Container(
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right:5.0),
                                                                  child: Icon(
                                                                    Icons.list,
                                                                    color: mainTextColor,
                                                                    size: 18,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "5 dernières opérations",
                                                                  style: TextStyle(
                                                                      letterSpacing: 1.0,
                                                                      color: mainTextColor,
                                                                      fontSize: 16.0,
                                                                      fontFamily: 'bebas'
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // Bloc operations
                                                        Padding(
                                                          padding: const EdgeInsets.only(top:10.0),
                                                          child: Container(
                                                              child: Table(
                                                                  border: TableBorder.symmetric(
                                                                      inside: BorderSide(
                                                                          width: 0,
                                                                          color: Colors.transparent
                                                                      ),
                                                                      outside: BorderSide(
                                                                        width: 2,
                                                                        color: mainTextColor,
                                                                      )
                                                                  ),
                                                                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                                                                  children: snapshot.data
                                                              )
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Bottom action buttons
                                Positioned(
                                  top: 330,
                                  //left: (width - 260) / 2,
                                  //left: width,
                                  child: Transform(
                                    transform: Matrix4.translationValues(0.0, delayedAnimation2.value * height, 0.0 ),
                                    child: Column(
                                      children: <Widget>[
                                        // Action buttons first line
                                        Container(
                                          width: width - 100,
                                          margin: EdgeInsets.only(left: 50),
                                          //color: Colors.yellow,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom:20.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                                  // Mkoudi
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
                                                    //margin: const EdgeInsets.only(left: 10.0),
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

                                                          },
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "images/mkoudi.png",
                                                                height: actionButtonIconHeight,
                                                                color: actionButtonTextColor,
                                                              ),
                                                              Text(
                                                                "Mkoudi",
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
                                                  // Mkoudi
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
                                                    //margin: const EdgeInsets.only(left: 10.0),
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

                                                            },
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: <Widget>[
                                                                Image.asset(
                                                                  "images/mkoudi.png",
                                                                  height: actionButtonIconHeight,
                                                                  color: actionButtonTextColor,
                                                                ),
                                                                Text(
                                                                  "Mkoudi",
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
                                          ),
                                        ),
                                        // Action buttons second line
                                        Container(
                                          width: width - 100,
                                          margin: EdgeInsets.only(left: 50),
                                          //color: Colors.yellow,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom:20.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  // Greffage
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
                                                  // Mkoudi
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
                                                    //margin: const EdgeInsets.only(left: 10.0),
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

                                                            },
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: <Widget>[
                                                                Image.asset(
                                                                  "images/mkoudi.png",
                                                                  height: actionButtonIconHeight,
                                                                  color: actionButtonTextColor,
                                                                ),
                                                                Text(
                                                                  "Mkoudi",
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
                                                  // Mkoudi
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
                                                    //margin: const EdgeInsets.only(left: 10.0),
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

                                                          },
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "images/mkoudi.png",
                                                                height: actionButtonIconHeight,
                                                                color: actionButtonTextColor,
                                                              ),
                                                              Text(
                                                                "Mkoudi",
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return new ListView(
                        children: <Widget>[
                          Text("${snapshot.error}"),
                        ]
                    );
                  }
                  // By default, show a loading spinner
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
                                    "Chargement",
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
              );
            }
          );
        },
        child: Text(
            "The child"
        ),
      )
    );
  }
}

