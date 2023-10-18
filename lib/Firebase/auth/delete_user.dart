import 'package:firebase_auth/firebase_auth.dart';

Future<void> deleteUser(
  String password,
  Function setLoading,
  Function deleteUserOk,
  Function deleteUserNotOk,
  Function deleteUserNotOkError,
  
) async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;
    setLoading();

    if (user != null) {
      // Reautenticar antes de realizar operaciones sensibles
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password, // Cambiar por la contraseña actual del usuario
      );

      await user.reauthenticateWithCredential(credential);

      // Ahora puedes proceder con la eliminación del usuario
      await user.delete();
      deleteUserOk();
    } else {
      print('No hay usuario logueado');
      deleteUserNotOk();
    }
  } on FirebaseException catch (e) {
    print('Error: ${e.code} ${e.message}');
    deleteUserNotOkError(e.code);
  } catch (e) {
    print('Error: $e');
    deleteUserNotOk();
  } finally {
    setLoading();
  }
}
