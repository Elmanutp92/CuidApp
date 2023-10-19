import 'package:cuida_app/pages/home/widget/profile_image_home.dart';
import 'package:cuida_app/pages/loading_page.dart';
import 'package:cuida_app/pages/login/login.dart';
import 'package:cuida_app/pages/profile_page/widget/go_home.dart';
import 'package:cuida_app/pages/profile_page/widget/gradient_background.dart';
import 'package:cuida_app/pages/profile_page/widget/more_menu.dart';

import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({Key? key}) : super(key: key);

  @override
  State<ProfilePage2> createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
  String userName = '';
  String userEmail = '';
  String creationTime = '';
  String userId = '';
  User? currentUser;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        currentUser = user;
        setState(() {
          userName = user.displayName.toString();
          userEmail = user.email.toString();
          creationTime = user.metadata.creationTime.toString();
          userId = user.uid.toString();
        });
      }
    });
    final Responsive responsive = Responsive(context);
    double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;
    double dz = responsive.diagonal;

    return Scaffold(
      body: !isLoading
          ? SizedBox(
              height: hz,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                          height: hz * 0.33,
                        ),
                        const GradientBackground(),
                        SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const GoToHome(),
                              Text(
                                'Perfil',
                                style: GoogleFonts.poppins(
                                  fontSize: dz * 0.03,
                                  color: AppColors.textColor,
                                ),
                              ),
                              MoreMenu(
                                  setLoading: setLoading,
                                  logOutOk: logOutOk,
                                  logOutNotOk: logOutNotOk,
                                  deleteUserOk: deleteUserOk,
                                  deleteUserNotOk: deleteUserNotOk,
                                  deleteUserNotOkError: deleteUserNotOkError)
                            ],
                          ),
                        ),
                        Positioned(
                          top: hz * 0.1,
                          left: wz * 0.3,
                          child: const ProfileImageHome(
                            wzo: 0.4,
                            hzo: 0.2,
                            border: true,
                            isHome: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                       // color: Colors.amber,
                        height: hz * 0.4,
                        width: wz,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              //color: Colors.red,
                              width: wz * 0.9,
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.user,
                                    size: dz * 0.03,
                                    color: AppColors.textColor,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        userName,
                                        style: GoogleFonts.poppins(
                                          fontSize: dz * 0.03,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                             // color: Colors.red,
                              width: wz * 0.9,
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.message,
                                    size: dz * 0.03,
                                    color: AppColors.textColor,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        userEmail,
                                        style: GoogleFonts.poppins(
                                          fontSize: dz * 0.017,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ),
                                  ),
              
                                ],
                              ),
                            ),
                            SizedBox(
                              //color: Colors.red,
                              width: wz * 0.9,
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.login,
                                    size: dz * 0.03,
                                    color: AppColors.textColor,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        creationTime,
                                        style: GoogleFonts.poppins(
                                          fontSize: dz * 0.021,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            )
          : const LoadingPage(),
    );
  }

  void setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void logOutOk() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sesión Cerrada'),
      ),
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  void logOutNotOk() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ups, Algo salió mal'),
      ),
    );
  }

  void deleteUserOk() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Cuenta Eliminada'),
      ),
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  void deleteUserNotOk() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ups, no se pudo eliminar la cuenta'),
      ),
    );
  }

  void deleteUserNotOkError(e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ups, Error: $e'),
      ),
    );
  }
}
