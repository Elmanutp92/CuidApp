import 'package:cuida_app/pages/home/home.dart';
import 'package:cuida_app/pages/loading_page.dart';
import 'package:cuida_app/pages/login/widget/form_login.dart';

import 'package:cuida_app/pages/register/widgets/header.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  double dz = 0;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;
    dz = responsive.diagonal;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: !isLoading
            ? SizedBox(
                width: wz,
                height: hz,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const HeaderLogin(),
                      SizedBox(height: hz * 0.05),
                      FormLogin(
                        
                        userNotFound: userNotFound,
                        setLoading: setLoading,
                        loginOk: loginOk,
                        passwordIconrrect: passwordIconrrect,
                      ),
                    ],
                  ),
                ),
              )
            : const LoadingPage(),
      ),
    );
  }

  void passwordIconrrect() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Center(
          child: Text(
            'Contraseña incorrecta',
            style: GoogleFonts.poppins(
              fontSize: dz * 0.02,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void userNotFound() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Center(
          child: Text(
            'Usuario no encontrado, Registrate o intenta de nuevo',
            style: GoogleFonts.poppins(
              fontSize: dz * 0.015,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void loginOk() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Center(
          child: Text(
            'Bienvenido',
            style: GoogleFonts.poppins(
              fontSize: dz * 0.02,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  
}
