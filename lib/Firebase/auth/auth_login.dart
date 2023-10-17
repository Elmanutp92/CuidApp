import 'package:firebase_auth/firebase_auth.dart';


Future<void> login(
  
  Function userNotFound,
  Function passwordIncorrect,
  Function loginOk,
  Function setLoading,
  String emailAddress,
  String password,
) async {
  try {
    setLoading();
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    
    if (credential.user != null ) {
      loginOk();
      // Puedes realizar acciones adicionales después del inicio de sesión exitoso.
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      userNotFound();
    } else if (e.code == 'wrong-password') {
      passwordIncorrect();
    } else {
      // Otros errores específicos de FirebaseAuthException pueden manejarse aquí.
      userNotFound();
      
      // Puedes mostrar un mensaje más genérico al usuario.
    }
  } catch (e) {
    
    return;
  } finally {
    setLoading();
  }
}
