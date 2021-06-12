import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.logout;
  User? _user;

  FirebaseAuth getInstance() {
    return FirebaseAuth.instance;
  }

  void watchAuthChange() {
    getInstance().authStateChanges().listen((user) {
      if (user == null && _user == null) {
        return;
      } else if (user != _user) {
        _user = user;
        changeFirebaseAuthStatus();
      }
    });
  }

  void changeFirebaseAuthStatus({FirebaseAuthStatus? firebaseAuthStatus}) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
      print("1");
    } else {
      if (_user != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.login;
        print("2");
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.logout;
        print("3");
      }
    }

    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { logout, progress, login }
