import 'dart:async';




import 'package:audioplayers/audioplayers.dart';
import 'package:cuida_app/pages/login/login.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailNoVerified extends StatefulWidget {
  const EmailNoVerified({super.key});

  @override
  State<EmailNoVerified> createState() => _EmailNoVerifiedState();
}

class _EmailNoVerifiedState extends State<EmailNoVerified> {
  
  double one = 0;
  double two = 0;

  @override
  void initState() {
    super.initState();
    // Llama a playSound al inicio para reproducir el sonido cuando la pantalla se carga
    final player = AudioPlayer();
    player.play(AssetSource('error.wav'));
    goToLogin();
  }

  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive(context);
     double dz = responsive.diagonal;



    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email no verificado',
                style: GoogleFonts.poppins(
                  fontSize: dz * 0.03,
                  color: AppColors.textColor,
                ),
              ),
              // animate by active flag
               Icon(Icons.close, size: dz * 0.1, color: Colors.red,),
              
            ],
          ),
        ),
      ),
    );
  }

 

  // Utiliza async y await para esperar el retraso
  Future<void> goToLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }
}
