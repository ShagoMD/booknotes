import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  // wrappinhg the firebase calls
  Future logout() async {
    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    return result;
  }

  // wrapping the firebase calls
  Future createUser(
      {String firstName,
      String lastName,
      String email,
      String password}) async {}

  // logs in the user if password matches
  Future<FirebaseUser> loginUser({String email, String password}) async {
    try {
      var result = (await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password))
          .user;
      // since something changed, let's notify the listeners...
      notifyListeners();
      return result;
    }  catch (e) {
      // throw the Firebase AuthException that we caught
      throw new AuthException(e.code, e.message);
    }
  }
}
