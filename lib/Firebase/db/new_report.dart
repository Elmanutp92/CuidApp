import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> newReport(
    String titulo,
    String descripcion,
    Function setLoading,
    Function newReportOk,
    Function newReportFail,
    String personId,
    String userEmail,
    String userId) async {
  final Map<String, dynamic> report = {
    'titulo': titulo,
    'descripcion': descripcion,
  };

  try {
    setLoading();

    final DocumentReference docRef = await _firestore
        .collection('users')
        .doc('$userEmail-$userId')
        .collection('personas')
        .doc(personId)
        .collection('reportes')
        .add(report);

    if (docRef.id.isNotEmpty) {
      String reportId = docRef.id;

      docRef.update({'id': reportId});
      newReportOk();
    } else {
      newReportFail();
    }
  } catch (error) {
    // Puedes manejar el error aquí, por ejemplo, mostrando un mensaje al usuario.
  } finally {
    setLoading();
  }
}
