import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final String? uId = FirebaseAuth.instance.currentUser?.uid;
final String? uEmail = FirebaseAuth.instance.currentUser?.email;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 



Future<void> newReport(
  String titulo, String descripcion, Function setLoading, Function newReportOk, Function newReportFail, String personId
) async {
  final Map<String, dynamic> report = {
    'titulo': titulo,
    'descripcion': descripcion,
   
    
    
  };

  try {
    setLoading();
    if ( uId != '' && personId.isNotEmpty) {
      final DocumentReference docRef = await _firestore
          .collection('users')
          .doc('$uEmail-$uId')
          .collection('personas').doc(personId).collection('reportes').add(report);
          

      if (docRef.id.isNotEmpty) {
        String reportId = docRef.id;

        docRef.update({'id': reportId});
        newReportOk();
      } else {
        newReportFail();
      }

      
    } else {
      // Manejar el caso en que el usuario no está autenticado.
    
      newReportFail();
    }
  } catch (error) {
    
    // Puedes manejar el error aquí, por ejemplo, mostrando un mensaje al usuario.
  } finally {
    setLoading();
  }
}
