import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuida_app/Firebase/db/delete_person.dart';
import 'package:cuida_app/Firebase/db/get_person.dart';
import 'package:cuida_app/Firebase/storage/get_image_person.dart';
import 'package:cuida_app/pages/detail_person/widget/info_data.dart';
import 'package:cuida_app/pages/detail_person/widget/reports.dart';
import 'package:cuida_app/pages/home/home.dart';
import 'package:cuida_app/pages/loading_page.dart';
import 'package:cuida_app/pages/profile_page/widget/profile_image.dart';
import 'package:cuida_app/styles/colors.dart';

import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class DetailPerson extends StatefulWidget {
  const DetailPerson({
    Key? key,
    required this.personLastName,
    required this.personAge,
    required this.personGender,
    required this.personId,
    required this.personName,
  }) : super(key: key);

  final String personLastName;
  final String personAge;
  final String personGender;
  final String personId;
  final String personName;

  @override
  State<DetailPerson> createState() => _DetailPersonState();
}

class _DetailPersonState extends State<DetailPerson> {
  String userId = '';
  String userEmail = '';
  String? urlImage = '';
  File? imageProfile;
  String userName = '';
  bool isLoading = false;

  Map<String, dynamic> data = {};

  

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
      } else {
        setState(() {
          userId = user.uid.toString();
          userEmail = user.email.toString();
          userName = user.displayName.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double hz = responsive.screenHeight;
    double dz = responsive.diagonal;
    double wz = responsive.screenWidth;

    return isLoading
        ? const LoadingPage()
        : Scaffold(
          backgroundColor: AppColors.backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await uploadImageFile(
                        context,
                        setImage,
                        urlImage.toString(),
                        true,
                        widget.personId,
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: hz * 0.35,
                      width: double.infinity,
                      child: FutureBuilder<String>(
                        future: getUrlImagePerson(
                            widget.personId, userId, userEmail, userName),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError ||
                              snapshot.data == 'Error') {
                            return Container(
                              color: Colors.red,
                              height: hz * 0.2,
                              width: double.infinity,
                              child: const Center(
                                child: Text(
                                  'Error',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else if (snapshot.hasData ||
                              snapshot.data.toString().isNotEmpty ||
                              snapshot.data.toString() != '') {
                            return snapshot.data.toString().isNotEmpty
                                ? Stack(
                                    children: [
                                      withBlurBackground(snapshot.data),
                                      Positioned(
                                        top: hz * 0.1,
                                        left: wz * 0.3,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: dz * 0.1,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  snapshot.data.toString()),
                                        ),
                                      ),
                                      SafeArea(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                Colors.black.withOpacity(0.5),
                                                Colors.transparent,
                                              ])),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                ),
                                                child: IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const HomePage()));
                                                    },
                                                    icon: Icon(
                                                      Iconsax.arrow_left_2,
                                                      color: Colors.green,
                                                      size: dz * 0.035,
                                                    )),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${widget.personName} ${widget.personLastName}',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: dz * 0.03,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        // Muestra el menú contextual
                                                        showMenu(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          color:
                                                              Colors.blue[100],
                                                          context: context,
                                                          position:
                                                              const RelativeRect
                                                                  .fromLTRB(
                                                                  100,
                                                                  50,
                                                                  0,
                                                                  50), // Ajusta las coordenadas según sea necesario
                                                          items: <PopupMenuEntry>[
                                                            const PopupMenuItem(
                                                              value: 1,
                                                              child: Center(
                                                                  child: Text(
                                                                      'Confirmar eliminación')),
                                                            ),
                                                            PopupMenuItem(
                                                                value: 2,
                                                                child: TextButton(
                                                                    onPressed: () async {
                                                                      await deletePerson(
                                                                        widget
                                                                            .personId,
                                                                        setLoading,
                                                                        userId,
                                                                        userEmail,
                                                                        context,
                                                                        deletePersonOk,
                                                                        deletePersonNotOk,
                                                                      );
                                                                    },
                                                                    child: Center(
                                                                        child: Text(
                                                                      'Eliminar Persona',
                                                                      style: GoogleFonts.poppins(
                                                                          color:
                                                                              Colors.red),
                                                                    )))),
                                                            // Agrega más elementos del menú según sea necesario
                                                          ],
                                                        );

                                                        // Llama a la función para eliminar la persona
                                                      },
                                                      icon: const Icon(
                                                          Iconsax.trash,
                                                          
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : SizedBox(
                                    height: hz * 0.2,
                                    width: double.infinity,
                                    child: Center(
                                        child: Icon(
                                      Iconsax.additem,
                                      size: dz * 0.1,
                                      color: Colors.grey,
                                    )),
                                  );
                          } else {
                            return Icon(
                              Iconsax.additem,
                              size: dz * 0.1,
                              color: Colors.grey,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  InfoData(
                    personId: widget.personId,
                    personName: widget.personName,
                    personLastName: widget.personLastName,
                    personAge: widget.personAge,
                    personGender: widget.personGender,
                  ),
                  Reports(
                    personId: widget.personId,
                    personName: widget.personName,
                  ),
                ],
              ),
            ),
          );
  }

  void setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void setImage(image) {
    setState(() {
      imageProfile = File(image);
    });
  }

  Widget withBlurBackground(imageUrl) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl.toString()),
              fit: BoxFit.cover,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  deletePersonOk() {
    final player = AudioPlayer();
    player.play(AssetSource('sound.mp3'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Persona eliminada'),
      ),
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  deletePersonNotOk() {
    final player = AudioPlayer();
    player.play(AssetSource('error.mp3'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error al eliminar'),
      ),
    );
    Navigator.pop(context);
  }
}
