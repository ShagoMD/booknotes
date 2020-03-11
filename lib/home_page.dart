import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authservice.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser currentUser; // ⇐ NEW

  HomePage(this.currentUser);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var androidVersionNames = ["a", "b", "c"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Flutter Firebase"),
        //actions: <Widget>[LogoutButton()],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Card(
              child: Text(androidVersionNames[position]),
            );
          },
          itemCount: androidVersionNames.length,
        ),
      ), 
      /*Center(
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Card(
              child: Text(androidVersionNames[position]),
            );
          },
          itemCount: androidVersionNames.length,
        ),
        /*RaisedButton(
                  child: Text("LOGOUT"),
                  onPressed: () async {
                    await Provider.of<AuthService>(context).logout();
                  })*/
      ),*/
    );
  }
}
