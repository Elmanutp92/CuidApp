import 'dart:async';

import 'package:cuida_app/pages/login/login.dart';
import 'package:cuida_app/pages/page_verification/widget/email_verified.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/copies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late Color _iconColor;
  late Timer _timer;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _iconColor = Colors.red;
    _startTimer();
    validar();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        setState(() {
          currentUser = user;
        });
      }
    });
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.email,
                  size: 100,
                  color: _iconColor,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  Copies.emailEnviado,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  userDelete();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _changeColor();
    });
  }

  void _changeColor() {
    setState(() {
      if (_iconColor == Colors.red) {
        _iconColor = Colors.green;
      } else if (_iconColor == Colors.green) {
        _iconColor = Colors.blue;
      } else {
        _iconColor = Colors.red;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> validar() async {
    while (currentUser == null || !currentUser!.emailVerified) {
      await Future.delayed(const Duration(seconds: 1));
      currentUser!.reload();
    }

    // Cancelar el temporizador una vez que el usuario esté verificado.
    _timer.cancel();

    // Navegar a la siguiente pantalla después de la verificación.
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EmailVerified()),
    );
  }

 void userDelete() async {
  try {
    if (currentUser != null) {
      print('El usuario no es null');

      // Intenta eliminar al usuario
      await currentUser!.delete();

      // Verifica si el usuario se eliminó correctamente
      bool userDeleted = FirebaseAuth.instance.currentUser == null;

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Center(
            child: Text(
              userDeleted ? 'Vuelve pronto' : 'Ups, algo salió mal',
              style: TextStyle(
                fontSize:  12 ,
                color: AppColors.textColor,
                fontWeight: userDeleted ? FontWeight.normal : FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: userDeleted ? AppColors.primaryColor : Colors.red,
        ),
      );

      // Redirige a la pantalla de inicio de sesión o a donde sea necesario
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } else {
      print('El usuario es null');
    }
  } catch (e) {
    print('Error de Firebase al eliminar el usuario: $e');
  }
}

}
