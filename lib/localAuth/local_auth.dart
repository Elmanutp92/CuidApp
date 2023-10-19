import 'package:local_auth/local_auth.dart';

Future<bool> authenticate() async {
  final localAuth = LocalAuthentication();

  try {
    // Verifica si el dispositivo tiene capacidades biométricas
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;

    if (canCheckBiometrics) {
      // Recupera la lista de tipos de autenticación biométrica disponibles (huella dactilar, rostro, etc.)
      List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();

      // Si hay al menos un tipo de autenticación biométrica disponible, intenta autenticar
      if (availableBiometrics.isNotEmpty) {
        bool isAuthenticated = await localAuth.authenticate(
          localizedReason: 'Por favor, autentica para continuar',
           // Permite que la autenticación persista en segundo plano
        );

        return isAuthenticated;
      } else {
        // No hay tipos de autenticación biométrica disponibles
        return false;
      }
    } else {
      // El dispositivo no es compatible con la autenticación biométrica
      return false;
    }
  } catch (e) {
    // Manejar errores aquí
   
    return false;
  }
}
