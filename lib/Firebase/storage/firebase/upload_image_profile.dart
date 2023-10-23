import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cuida_app/pages/profile_page/profile_page2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<String> uploadImageProfile(File image, String userName, String userId, context) async {
  try {
    final String fileName =
        '$userName-$userId';
    final Reference imageRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileName);
    final UploadTask uploadTask = imageRef.putFile(image);

    final TaskSnapshot snapshot = await uploadTask;
    if (snapshot.state == TaskState.success) {
       final player = AudioPlayer();
    player.play(AssetSource('sound.mp3'));
      final downloadURL = await snapshot.ref.getDownloadURL();
      Navigator.push(context, MaterialPageRoute(builder:(context) => const ProfilePage2()));
      return downloadURL;
    } else {
       final player = AudioPlayer();
    player.play(AssetSource('error.mp3'));
      return 'Error';
    }
  } catch (e) {
     final player = AudioPlayer();
    player.play(AssetSource('error.mp3'));
    return 'Error';
  }
}
