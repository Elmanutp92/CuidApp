import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImagePerson(File image, String personId) async {
  final User? user = FirebaseAuth.instance.currentUser;
  try {
    final String fileName = '${user!.displayName}${user.uid}';
    final Reference imageRef = FirebaseStorage.instance
        .ref()
        .child(user.uid)
        .child(fileName)
        .child('person')
        .child(user.email!).child('imagen').child(personId);
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
