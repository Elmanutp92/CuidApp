import 'package:cuida_app/pages/home/home.dart';
import 'package:cuida_app/pages/loading_page.dart';
import 'package:cuida_app/pages/page_verification/page_verification.dart';
import 'package:cuida_app/pages/register/widgets/form_register.dart';
import 'package:cuida_app/pages/register/widgets/header.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;
  double dz = 0;

  void setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

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
                      FormRegister(
                        sendEmailVerificationOk: sendEmailVerificationOk,
                        setLoading: setLoading,
                        emailInUse: emailInUse,
                        registerOk: registerOk,
                      ),
                    ],
                  ),
                ),
              )
            : const LoadingPage(),
      ),
    );
  }

  void emailInUse() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Center(
          child: Text(
            'El email ya esta en uso',
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

  void registerOk() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Center(
          child: Text(
            'Registro exitoso',
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

  void sendEmailVerificationOk() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VerificationPage()),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Center(
          child: Text(
            'Verifica tu correo',
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
  }
}
