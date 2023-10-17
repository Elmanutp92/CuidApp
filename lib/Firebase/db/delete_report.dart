import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> deleteReport(
    String personId, Function setLoading, String reportId, String userId) async {
  try {
    setLoading();
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('personas')
        .doc(personId)
        .collection('reportes')
        .doc(reportId)
        .delete();
  } catch (e) {
    // Puedes realizar acciones adicionales en caso de error
  } finally {
    setLoading();
  }

  // Puedes manejar el caso en que uId es nulo
}
