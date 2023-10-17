import 'package:cuida_app/pages/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> logOut(context, Function setLoading, Function logOutOk,
    Function logOutNotOk) async {
  try {
    setLoading();
    await FirebaseAuth.instance.signOut();
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      logOutOk();
    } else {
      logOutNotOk();
    }
  } catch (e) {
    return;
  }

  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const Login()));
}
