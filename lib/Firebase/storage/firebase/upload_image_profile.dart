import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImageProfile(File image) async {
  try {
    final String fileName =
        '${FirebaseAuth.instance.currentUser!.displayName}${FirebaseAuth.instance.currentUser!.uid.toString()}';
    final Reference imageRef = FirebaseStorage.instance
        .ref()
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
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
