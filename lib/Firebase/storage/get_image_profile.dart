import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Stream<String> getUrlImageProfile() async* {
  try {
    final Reference refUrl = FirebaseStorage.instance
        .ref()
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .child( '${FirebaseAuth.instance.currentUser!.displayName}${FirebaseAuth.instance.currentUser!.uid.toString()}');

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

