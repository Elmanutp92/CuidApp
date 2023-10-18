import 'package:cuida_app/Firebase/auth/delete_user.dart';
import 'package:cuida_app/Firebase/auth/log_out.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class MoreMenu extends StatefulWidget {
   MoreMenu({super.key, required this.setLoading, required this.logOutOk, required this.logOutNotOk, required this.deleteUserOk, required this.deleteUserNotOk, required this.deleteUserNotOkError, this.currentUser});
  final Function setLoading;
  final Function logOutOk;
  final Function logOutNotOk;
  final Function deleteUserOk;
  final Function deleteUserNotOk;
  final Function deleteUserNotOkError;
  final User? currentUser;
  

  @override
  State<MoreMenu> createState() => _MoreMenuState();
}

class _MoreMenuState extends State<MoreMenu> {
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;
    double dz = responsive.diagonal;
    return IconButton(
      onPressed: () {
        showMenu(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.lightBlue[100],
          context: context,
          position: const RelativeRect.fromLTRB(10, 30, 0, 0),
          items: [
            PopupMenuItem(
              onTap: () => logOut(context, widget.setLoading, widget.logOutOk, widget.logOutNotOk),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Cerrar sesión'),
                  Icon(Iconsax.logout),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: AppColors.backgroundColor,
                    title: const Row(
                      children: [
                        Text('Eliminar Cuenta'),
                        Icon(Iconsax.profile_delete),
                      ],
                    ),
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                            widget.setLoading,
                            widget.deleteUserOk,
                            widget.deleteUserNotOk,
                            widget.deleteUserNotOkError,
                            
                          );
                        },
                        child: Text(
                          'Eliminar',
                          style: GoogleFonts.poppins(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Eliminar cuenta'),
                  Icon(Iconsax.profile_delete),
                ],
              ),
            ),
          ],
        ).then((value) {
          // Maneja la opción seleccionada si es necesario
          if (value != null) {
            print('Opción seleccionada: $value');
          }
        });
      },
      icon: const Icon(Iconsax.more),
      color: AppColors.textColor,
    );
  }
}
