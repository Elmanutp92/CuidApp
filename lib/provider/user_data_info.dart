import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDataInfo extends ChangeNotifier {
  String _uid = '';
  String _userName = '';
  String _userEmail = '';
  String _metadata = '';

  DataInfo() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _uid = user.uid;
      _userName = user.displayName!;
      _userEmail = user.email!;
      _metadata = user.metadata.toString();
    } else {
      _uid = '';
      _userName = '';
      _userEmail = '';
      _metadata = '';
    }
  }

  String get userName => _userName;
  String get uid => _uid;
  String get userEmail => _userEmail;
  String get metadata => _metadata;
}
