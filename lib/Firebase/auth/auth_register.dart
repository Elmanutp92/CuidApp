import 'package:firebase_auth/firebase_auth.dart';

Future<void> register(
  Function sendEmailVerificationOk,
  Function emailInUse,
  Function registerOk,
  Function setLoading,
  String emailAddress,
  String password,
  String name,
  context,
) async {
  try {
    setLoading();
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    if (credential.user != null) {
      await credential.user!.updateDisplayName(name);
      credential.user!.sendEmailVerification();
      sendEmailVerificationOk();
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
  
    } else if (e.code == 'email-already-in-use') {
      emailInUse();
    }
  } catch (e) {
   return;
  } finally {
    setLoading();
    
  }
}
