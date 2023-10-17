import 'package:cuida_app/Firebase/auth/delete_user.dart';
import 'package:cuida_app/Firebase/auth/log_out.dart';
import 'package:cuida_app/pages/home/home.dart';

import 'package:cuida_app/pages/loading_page.dart';
import 'package:cuida_app/pages/login/login.dart';
import 'package:cuida_app/pages/profile_page/widget/header_profile.dart';

import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.metaData,
  });
  final String userName;
  final String userEmail;
  final String metaData;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    double hz = responsive.screenHeight;
    double wz = responsive.screenWidth;
    return !isLoading
        ? Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              automaticallyImplyLeading: false,
              iconTheme: const IconThemeData(
                color: AppColors.primaryColor,
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Perfil',
                style: GoogleFonts.poppins(
                  fontSize: dz * 0.03,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.white,
                    AppColors.primaryColor.withOpacity(0.2),
                  ])),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Informacion del Usuario',
                      style: GoogleFonts.poppins(
                        fontSize: dz * 0.02,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    SizedBox(
                      height: hz * 0.18,
                      child: Column(
                        children: [
                          CardProfile(
                              userName: widget.userName,
                              userEmail: widget.userEmail,
                              metaData: widget.metaData),
                          Text(
                            'Fecha de Registro: ${widget.metaData}',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.poppins(
                              fontSize: dz * 0.015,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          await logOut(
                              context, setLoading, logOutOk, logOutNotOk);
                        },
                        child: const Text(
                          'Cerrar Sesion',
                          style: TextStyle(color: Colors.red),
                        )),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppColors.backgroundColor,
                              title: const Text('Eliminar Cuenta'),
                              content: SizedBox(
                                height: hz * 0.15,
                                width: wz * 0.8,
                                child: Column(
                                  children: [
                                    Text(
                                        'Ingrese su contraseña para eliminar su cuenta',
                                        style: GoogleFonts.poppins(
                                          fontSize: dz * 0.015,
                                          color: AppColors.textColor,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          labelText: 'Contraseña',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await deleteUser(
                                      _passwordController.text,
                                      setLoading,
                                      deleteUserOk,
                                      deleteUserNotOk,
                                      deleteUserNotOkError,
                                    );
                                  },
                                  child: Text('Eliminar',
                                      style: GoogleFonts.poppins(
                                          color: Colors.red)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Eliminar Cuenta',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        : const LoadingPage();
  }

  void setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void logOutOk() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sesion Cerrada'),
      ),
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  void logOutNotOk() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ups, Algo salio mal'),
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(
                  userEmail: widget.userEmail,
                  metaData: widget.metaData,
                  userName: widget.userName,
                )));
  }

  void deleteUserNotOkError(e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ups, Error: $e'),
      ),
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(
                  userEmail: widget.userEmail,
                  metaData: widget.metaData,
                  userName: widget.userName,
                )));
  }
}
