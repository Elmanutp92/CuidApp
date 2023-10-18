import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImagePerson(File image, String personId, String userName, String userId) async {

  try {
    final String fileName = '$userName-$userId';
    final Reference imageRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(personId)
        .child(fileName);
    final UploadTask uploadTask = imageRef.putFile(image);

    final TaskSnapshot snapshot = await uploadTask;
    if (snapshot.state == TaskState.success) {
      final downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } else {
      return 'Error';
    }
  } catch (e) {
    return 'Error';
  }
}
