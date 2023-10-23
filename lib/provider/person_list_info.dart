import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonListProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _personList = [];
  late StreamController<List<Map<String, dynamic>>> _controller;

  PersonListProvider() {
    _controller = StreamController<List<Map<String, dynamic>>>.broadcast();
    _loadPersonList();
  }

  Stream<List<Map<String, dynamic>>> get personListStream => _controller.stream;

  Future<void> _loadPersonList() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc('${FirebaseAuth.instance.currentUser!.email}-${FirebaseAuth.instance.currentUser!.uid}')
          .collection('personas')
          .get();

      _personList = snapshot.docs.map((doc) => doc.data()).toList();
      _controller.add(_personList); // Notifica al StreamController sobre el cambio
      notifyListeners();
    } catch (error) {
      // Maneja el error según tus necesidades
    
    }
  }
}
