import 'package:cuida_app/Firebase/auth/auth_login.dart';
import 'package:cuida_app/pages/register/register.dart';

import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({
    super.key,
    required this.setLoading,
    required this.loginOk,
    required this.passwordIconrrect,
    required this.userNotFound,
    
  });

  final Function setLoading;
  final Function loginOk;
  final Function passwordIconrrect;
  final Function userNotFound;
 

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  bool obscurePass = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool validarCorreo(String correo) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return regex.hasMatch(correo);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;
    double dz = responsive.diagonal;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: _formKey,
          child: SizedBox(
            height: hz * 0.77,
            child: Column(
              children: [
                Text(
                  'inicia Sesion',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    cursorColor: AppColors.textColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un email';
                      }
                      if (!validarCorreo(value)) {
                        return 'Por favor ingrese un correo valido';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Correo',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: dz * 0.02,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: AppColors.textColor,
                    obscureText: obscurePass,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una contraseña';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePass = !obscurePass;
                          });
                        },
                        icon: Icon(
                          obscurePass ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.textColor,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Contraseña',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: dz * 0.02,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: hz * 0.09,
                  width: wz * 0.8,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.accentColor,
                        AppColors.primaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await login(
                          widget.userNotFound,
                          widget.passwordIconrrect,
                          widget.loginOk,
                          widget.setLoading,
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    child: Text(
                      'Ingresar',
                      style: GoogleFonts.poppins(
                        fontSize: dz * 0.02,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: Text(
                      'Crear cuenta',
                      style: GoogleFonts.poppins(
                        fontSize: dz * 0.016,
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
