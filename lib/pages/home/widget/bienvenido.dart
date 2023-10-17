import 'dart:ui';

import 'package:cuida_app/Firebase/storage/get_image_profile.dart';
import 'package:cuida_app/pages/home/widget/profile_image_home.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bienvenido extends StatefulWidget {
  const Bienvenido({super.key, });
  

  @override
  State<Bienvenido> createState() => _BienvenidoState();
}

class _BienvenidoState extends State<Bienvenido> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    double wz = responsive.screenWidth;
    //double hz = responsive.screenHeight;

    return StreamBuilder<String>(
      stream: getUrlImageProfile(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Container(
          height: wz * 0.3,
          child: Stack(
            children: [Stack(
              children: [Container(
                width: wz ,
                decoration: BoxDecoration(
                  image: snapshot.hasData && snapshot.data!.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(snapshot.data!),
                          fit: BoxFit.cover,
                        )
                      : null, // Puedes agregar un fondo por defecto o dejarlo en blanco
                ),
               
              ),
              BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
            ]),
             SizedBox(
              width: wz,
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'CuidApp',
                        style: GoogleFonts.poppins(
                          fontSize: dz * 0.05,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Hola, ',
                            style: GoogleFonts.poppins(
                              fontSize: dz * 0.02,
                              color: AppColors.textColor,
                            ),
                          ),
                          Text(
                        FirebaseAuth.instance.currentUser!.displayName.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: dz * 0.02,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                        ],
                      ),
                      
                    ],
                  ),
                  const ProfileImageHome(wzo: 0.2, hzo: 0.1, border: true, isHome: true)
                ],
                         ),
             ),
               ] ),
        );
      },
    );
  }
}
