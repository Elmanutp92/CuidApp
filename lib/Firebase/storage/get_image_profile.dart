
import 'package:firebase_storage/firebase_storage.dart';

Stream<String> getUrlImageProfile(String userId, String userName) async* {
  try {
    final Reference refUrl = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child( '$userName-$userId');

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

