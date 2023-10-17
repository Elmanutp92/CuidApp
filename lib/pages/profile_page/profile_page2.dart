import 'dart:ui';

import 'package:cuida_app/Firebase/auth/delete_user.dart';
import 'package:cuida_app/Firebase/auth/log_out.dart';
import 'package:cuida_app/Firebase/storage/get_image_profile.dart';
import 'package:cuida_app/pages/home/home.dart';
import 'package:cuida_app/pages/home/widget/profile_image_home.dart';
import 'package:cuida_app/pages/loading_page.dart';
import 'package:cuida_app/pages/login/login.dart';

import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({super.key});

  @override
  State<ProfilePage2> createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
  String userName = '';
  String userEmail = '';
  String userMetadata = '';
  String userId = '';
  User? currentUser;
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    
     FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        setState(() {
          userName = user.displayName.toString();
          userEmail = user.email.toString();
          userMetadata = user.metadata.creationTime.toString();
          currentUser = user;
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
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            //color: Colors.amber,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                          height: hz * 0.33,
                        ),
                        StreamBuilder<String>(
                            stream: getUrlImageProfile(
                              userId,
                              userName,
                            ),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              return Stack(children: [
                                Container(
                                    height: hz * 0.22,
                                    decoration: snapshot.hasData &&
                                            snapshot.data!.isNotEmpty
                                        ? BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(50),
                                              bottomRight: Radius.circular(50),
                                            ),
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(snapshot.data!),
                                              fit: BoxFit.cover,
                                            )
                                            // Puedes agregar un fondo por defecto o dejarlo en blanco
                                            )
                                        : BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(50),
                                              bottomRight: Radius.circular(50),
                                            ),
                                          )),
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ]);
                            }),
                        SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ));
                                },
                                icon: const Icon(Icons.arrow_back),
                                color: Colors.white,
                              ),
                              Text('Perfil',
                                  style: GoogleFonts.poppins(
                                    fontSize: dz * 0.03,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                onPressed: () {
                                  showMenu(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: Colors.lightBlue[100],
                                    context: context,
                                    position: const RelativeRect.fromLTRB(
                                        10, 30, 0, 0),
                                    items: [
                                      PopupMenuItem(
                                        onTap: () => logOut(context, setLoading,
                                            logOutOk, logOutNotOk),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
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
                                              backgroundColor:
                                                  AppColors.backgroundColor,
                                              title: const Row(
                                                children: [
                                                  Text('Eliminar Cuenta'),
                                                  Icon(Iconsax.profile_delete)
                                                ],
                                              ),
                                              content: SizedBox(
                                                height: hz * 0.15,
                                                width: wz * 0.8,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        'Ingrese su contraseña para eliminar su cuenta',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: dz * 0.015,
                                                          color: AppColors
                                                              .textColor,
                                                        )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextFormField(
                                                        controller:
                                                            _passwordController,
                                                        obscureText: true,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          labelText:
                                                              'Contraseña',
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
                                                      currentUser,
                                                    );
                                                  },
                                                  child: Text('Eliminar',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.red)),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
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
                                color: Colors.white,
                              ),
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
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(userName.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: dz * 0.03,
                              color: Colors.black,
                            )),
                      ),
                    )
                  ],
                ),
              )
            : const LoadingPage());
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
            builder: (context) =>const  ProfilePage2(
                
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
            builder: (context) => const ProfilePage2(
                  
                )));
  }
}
