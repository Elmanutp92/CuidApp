import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final User? user = FirebaseAuth.instance.currentUser;

Stream<String> getUrlImagePerson(String personId, String userId, String userEmail, String userName) async* {
   
   
  try {
    final String fileName = '$userName-$userId';

    final Reference refUrl = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileName).child('person')
        .child(userEmail).child('imagen').child(personId);

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

