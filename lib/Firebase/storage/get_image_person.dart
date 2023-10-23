import 'package:firebase_storage/firebase_storage.dart';

Future<String> getUrlImagePerson(String personId, String userId, String userEmail, String userName) async {
  try {
    final String fileName = '$userName-$userId';

    final Reference refUrl = FirebaseStorage.instance.ref().child(userId).child(personId).child(fileName);

    final String url = await refUrl.getDownloadURL();
    
    // Verificar si la URL está vacía o nula antes de retornar
    return url.isNotEmpty == true ? url : '';
  } on FirebaseException catch (e) {
    if (e.code == 'object-not-found') {
      // Manejar específicamente el caso cuando el objeto no se encuentra
      
      return '';
    } else {
      // Manejar otras excepciones de Firebase de manera más descriptiva
      
      return '';
    }
  } catch (e) {
    // Manejar otras excepciones de manera más descriptiva

    return '';
  }
}
