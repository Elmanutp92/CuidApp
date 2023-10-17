import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderLogin extends StatefulWidget {
  const HeaderLogin({super.key});

  @override
  State<HeaderLogin> createState() => _HeaderLoginState();
}

class _HeaderLoginState extends State<HeaderLogin> {
  final String title = 'CuidApp';
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    return Center(
        child: SafeArea(
      child: Stack(children: [
        Positioned(
            top: 4,
           child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: dz * 0.07,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
                 ),
         ),
         Positioned(
            top: 2,
           child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: dz * 0.07,
              fontWeight: FontWeight.bold,
              color: AppColors.accentColor,
            ),
                 ),
         ),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: dz * 0.07,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
       
      ]),
    ));
  }
}
