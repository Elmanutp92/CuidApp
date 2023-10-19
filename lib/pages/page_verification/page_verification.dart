import 'dart:async';

import 'package:cuida_app/pages/login/login.dart';
import 'package:cuida_app/pages/page_verification/widget/email_no_verified.dart';
import 'package:cuida_app/pages/page_verification/widget/email_verified.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/copies.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  VerificationPageState createState() => VerificationPageState();
}

class VerificationPageState extends State<VerificationPage> {
  late Timer _timer;
  User? currentUser;
  int milliseconds = 20000;
  double progress = 0.75;
  bool isLoading = false;
  bool isVerified = false;

  @override
  void initState() {
    super.initState();

    startCountdown();
    validar();
  }

  double progressWc() {
    if (progress > 0.0) {
      return MediaQuery.of(context).size.width * progress;
    } else {
      return 0;
    }
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (milliseconds > 0) {
        setState(() {
          milliseconds = milliseconds - 1;
          progress = progress - 0.0000375;
        });
      } else {
   
        _timer.cancel();
        userDelete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;
    double dz = responsive.diagonal;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
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
                child: Icon(Icons.send, size: dz * 0.1, color: Colors.grey),
              ),
              SizedBox(
                width: wz * 0.75,
                child: Text(
                  Copies.emailEnviado,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: dz * 0.02,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              !isLoading
                  ? Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      width: wz * 0.75,
                      height: hz * 0.01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: progress >= 0 && progress < 0.25
                            ? Colors.red
                            : progress > 0.25 && progress <= 0.5
                                ? Colors.yellow
                                : Colors.green,
                      ),
                      width: progressWc(),
                      height: hz * 0.01,
                    ),
                  ])
                  : const CircularProgressIndicator(),
              TextButton(
                onPressed: () {
                  _timer.cancel();
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void validar() {
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    await currentUser!.reload();
    
    if (currentUser!.emailVerified) {
   
      setState(() {
        isVerified = true;
      });

      // Cancela el temporizador una vez que el usuario esté verificado.
      timer.cancel();
      _timer.cancel();

      // Ignora de manera asíncrona para evitar problemas con el contexto.
      Future.delayed(Duration.zero, () {
        // Navega a la siguiente pantalla después de la verificación.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => 
                const EmailVerified(),
          ),
        );
      });
    } else {
   
    }
  });
}


  void userDelete() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (currentUser != null) {
        

        // Intenta eliminar al usuario
        await currentUser!.delete();

        // Verifica si el usuario se eliminó correctamente
        bool userDeleted = FirebaseAuth.instance.currentUser == null;


        isVerified
            // ignore: use_build_context_synchronously
            ? ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Center(
                    child: Text(
                      userDeleted ? 'Vuelve pronto' : 'Ups, algo salió mal',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textColor,
                        fontWeight:
                            userDeleted ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                  ),
                  backgroundColor:
                      userDeleted ? AppColors.primaryColor : Colors.red,
                ),
              )
            : null;

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  isVerified ? const Login() : const EmailNoVerified()),
        );
      } else {
     
      }
    } catch (e) {
   return;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
