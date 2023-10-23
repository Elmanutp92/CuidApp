import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> deleteReport(
    Function deleteOk, Function deleteNotOk, String personId, Function setLoading, String reportId, String userId, String userEmail) async {
  try {
    print('Eliminando reporte...');
    setLoading();
    
    await _firestore
        .collection('users')
        .doc('$userEmail-$userId')
        .collection('personas')
        .doc(personId)
        .collection('reportes')
        .doc(reportId)
        .delete();

    deleteOk();
  } on FirebaseException  {
    print('Error al eliminar reporte en Firebase');
  }
   catch (e) {
    print('Error al eliminar reporte: $e');
  
    deleteNotOk();
    // Maneja el error como desees, por ejemplo, imprimirlo en la consola.
   
  } finally {
    setLoading();
  }
}
