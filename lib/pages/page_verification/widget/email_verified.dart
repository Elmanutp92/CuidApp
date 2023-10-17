import 'dart:async';

import 'package:animated_checkmark/animated_checkmark.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cuida_app/pages/home/home.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerified extends StatefulWidget {
  const EmailVerified({super.key});

  @override
  State<EmailVerified> createState() => _EmailVerifiedState();
}

class _EmailVerifiedState extends State<EmailVerified> {
  final AudioPlayer sound = AudioPlayer();
  double one = 0;
  double two = 0;

  @override
  void initState() {
    super.initState();
    // Llama a playSound al inicio para reproducir el sonido cuando la pantalla se carga
    playSound();
    goToHome();
  }

  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive(context);
    final double dz = responsive.diagonal;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email verificado',
              style: GoogleFonts.poppins(
                fontSize: dz * 0.03,
                color: AppColors.textColor,
              ),
            ),
            // animate by active flag
            const AnimatedCheckmark(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 500),
              active: true,
              weight: 2,
              size: Size.square(100),
              color: AppColors.primaryColor,
              style: CheckmarkStyle.round,
            ),
            
          ],
        ),
      ),
    );
  }

  Future<void> playSound() async {
    try {
      await sound.play(volume: 1.0, AssetSource('assets/sound.mp3'));
    } catch (e) {
      print('Error al reproducir el sonido $e');
    }
  }

  // Utiliza async y await para esperar el retraso
  Future<void> goToHome() async {
    await Future.delayed(const Duration(seconds: 1));
    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
