import 'package:firebase_auth/firebase_auth.dart';


class Copies {
  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static String get userName =>
      currentUser?.displayName ?? 'Nombre de Usuario Desconocido';

  static String get userEmail =>
      currentUser?.email ?? 'Correo Electrónico Desconocido';

  static String get emailEnviado =>
      currentUser != null
          ? 'Hola, $userName. \nHemos enviado un link a tu correo $userEmail, por favor verifica tu bandeja de entrada y/o correo no deseado.\n \nEste paso es necesario para verificar tu cuenta.' : 'Usuario no encontrado.';
          
    
    static String get validandoEmail => currentUser != null ? 'Estamos validando tu email, espera un momento.' : 'Usuario no encontrado';

  
} 
