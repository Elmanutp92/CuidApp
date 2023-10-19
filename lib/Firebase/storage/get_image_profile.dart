import 'package:firebase_storage/firebase_storage.dart';

Future<String?> getUrlImageProfile(String userId, String userName) async {
  try {
    final String fileName = '$userName-$userId';
    final Reference refUrl = FirebaseStorage.instance.ref().child(userId).child(fileName);

    final String url = await refUrl.getDownloadURL();

    if (url.isNotEmpty) {
    
      return url;
    } else {
    
      return null;
    }
  } on FirebaseException catch (e) {
    if (e.code == 'object-not-found') {
   
      return null;
    } else {
     
    }
    return null;
  } catch (error) {
   
    return null;
  }
}
