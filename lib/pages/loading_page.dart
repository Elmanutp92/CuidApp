import 'dart:async';

import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  var color = 0;

  void colorDate() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        color++;
      });
    });
  }

  @override
  void initState() {
    colorDate();
    super.initState();
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
              Text('Cargando...',
                  style: GoogleFonts.poppins(
                      fontSize: dz * 0.03, color: AppColors.textColor)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: color % 2 == 0 ? AppColors.primaryColor : AppColors.accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
