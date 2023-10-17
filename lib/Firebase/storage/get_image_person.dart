import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final User? user = FirebaseAuth.instance.currentUser;

Stream<String> getUrlImagePerson(String personId) async* {
   final User? user = FirebaseAuth.instance.currentUser;
   
  try {
    final String fileName = '${user!.displayName}${user.uid}';

    final Reference refUrl = FirebaseStorage.instance
        .ref()
        .child(user.uid)
        .child(fileName).child('person')
        .child(user.email!).child('imagen').child(personId);

    final String url = await refUrl.getDownloadURL();
    if (url.isNotEmpty) {
      yield url;
    } else {
      yield ''; // Emite una cadena vacía en lugar de 'Error'
    }
  } on FirebaseException catch (e) {
    if (e.code == 'object-not-found') {
      yield ''; // Emite una cadena vacía en lugar de 'Error'
    } else {
      yield ''; // Emite una cadena vacía en lugar de 'Error'
    }
  } catch (e) {
    print('Error al obtener la URL de la imagen: $e');
    yield ''; // Emite una cadena vacía en lugar de 'Error'
  }
}

