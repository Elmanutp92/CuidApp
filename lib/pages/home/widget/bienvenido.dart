import 'dart:ui';

import 'package:cuida_app/Firebase/storage/get_image_profile.dart';
import 'package:cuida_app/pages/home/widget/profile_image_home.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bienvenido extends StatefulWidget {
  const Bienvenido({
    super.key,
  });

  @override
  State<Bienvenido> createState() => _BienvenidoState();
}

class _BienvenidoState extends State<Bienvenido> {
  String userName = '';
  String userId = '';
  String? urlImage = '';
  bool isFutureCalled = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
      
      } else {
        setState(() {
          userName = user.displayName.toString();
          userId = user.uid.toString();
        });

        // Llamamos al Future solo si no se ha llamado antes
        if (!isFutureCalled) {
          isFutureCalled = true;
          loadUrlImage();
        }
      }
    });
  }

  Future<void> loadUrlImage() async {
    final url = await getUrlImageProfile(userId, userName);
    if (url != null) {
      // Solo actualizamos el estado si la URL no es nula
      setState(() {
        urlImage = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    double wz = responsive.screenWidth;
    //double hz = responsive.screenHeight;

    return FutureBuilder<String?>(
      future: Future.value(urlImage),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Stack(
            children: [
              Positioned(
                top: 12,
                child: SizedBox(
                    width: wz,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    )),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.connectionState == ConnectionState.done ||
            snapshot.hasData ||
            snapshot.data != null) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: wz * 0.3,
            child: Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      width: wz,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),

                          image: DecorationImage(
                            
                        image: NetworkImage(snapshot.data.toString()),
                        fit: BoxFit.cover,
                      )),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        decoration:  BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                              color: AppColors.textColor, // Color del texto
                              shadows: [
                                const Shadow(
                                  color: Colors.white, // Color del borde
                                  offset: Offset(0, 0),
                                  blurRadius: 10, // Ancho del borde
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Hola, ',
                                style: GoogleFonts.poppins(
                                  fontSize: dz * 0.02,
                                  color: AppColors.textColor,
                                  shadows: [
                                const Shadow(
                                  color: Colors.white, // Color del borde
                                  offset: Offset(0, 0),
                                  blurRadius: 10, // Ancho del borde
                                ),
                              ],
                                  
                                ),
                              ),
                              Text(
                                userName,
                                style: GoogleFonts.poppins(
                                  fontSize: dz * 0.02,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                  shadows: [
                                const Shadow(
                                  color: Colors.white, // Color del borde
                                  offset: Offset(0, 0),
                                  blurRadius: 10, // Ancho del borde
                                ),
                              ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const ProfileImageHome(
                        wzo: 0.2,
                        hzo: 0.1,
                        border: true,
                        isHome: true,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
