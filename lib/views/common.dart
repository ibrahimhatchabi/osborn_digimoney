import 'package:flutter/material.dart';
import 'package:osborn_digimoney/views/profil.dart';

Widget myAppBar(context){
  return AppBar(
    backgroundColor: const Color(0xFF2584fc),
    elevation: 0,
    title: Image.asset(
      "images/osborn-text.png",
      color: Colors.white,
      height: 30,
    ),
    centerTitle: true,
    leading: IconButton(
      icon: Icon(
          Icons.exit_to_app
      ),
      color: Colors.white,
      onPressed: (){
        print("Exit pressed !!");
      },
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
            Icons.person_outline
        ),
        color: Colors.white,
        onPressed: (){
          Navigator.of(context)
            ..push(MaterialPageRoute(
              builder: (BuildContext context) => Profil()
            )
          );
        },
      ),
    ],
  );
}

MaterialPageRoute myNetworkErrorPopup(){
  return MaterialPageRoute(
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
                          "Vous avez besoin d'internet pour cette opération. Veuillez verifier votre internet et réessayer !!!",
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
  );
}
