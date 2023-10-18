import 'package:firebase_storage/firebase_storage.dart';

Future<String?> getUrlImageProfile(String userId, String userName) async {
  try {
    final String fileName = '$userName-$userId';
    final Reference refUrl = FirebaseStorage.instance.ref().child(userId).child(fileName);

    final String url = await refUrl.getDownloadURL();

    if (url.isNotEmpty) {
      print('URL de la imagen obtenida correctamente: $url');
      return url;
    } else {
      print('Error: URL de la imagen vacía.');
      return null;
    }
  } on FirebaseException catch (e) {
    if (e.code == 'object-not-found') {
      print('Error: El objeto PROFILE IMAGE ${userName}-${userId} no se encuentra en Firebase Storage.');
      return null;
    } else {
      print('Error de Firebase al obtener la URL de la imagen: $e');
    }
    return null;
  } catch (error) {
    print('Error inesperado al obtener la URL de la imagen: $error');
    return null;
  }
}
