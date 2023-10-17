import 'dart:io';
import 'dart:ui';

import 'package:cuida_app/Firebase/db/get_person.dart';
import 'package:cuida_app/Firebase/storage/get_image_person.dart';
import 'package:cuida_app/pages/detail_person/widget/info_data.dart';
import 'package:cuida_app/pages/detail_person/widget/reports.dart';
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
  final User? user = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> data = {};

  void getData() async {
    try {
      data = await getPerson(widget.personId, userEmail, userId);
    } catch (e) {
      print('Error al obtener el documento de la persona: $e');
      return;
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
     FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        setState(() {
          userId = user.uid.toString();
          userEmail = user.email.toString();
          userName = user.displayName.toString();
        });
      }
    });
    final Responsive responsive = Responsive(context);
    double hz = responsive.screenHeight;
    double dz = responsive.diagonal;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          '${widget.personName} ${widget.personLastName}',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: AppColors.textColor,
          ),
        ),
      ),
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
              child: Column(
                children: [
                  Container(
                    height: hz * 0.2,
                    width: double.infinity,
                    child: StreamBuilder<String>(
                      stream: getUrlImagePerson(widget.personId, userId, userEmail, userName 
                      ),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError ||
                            snapshot.data == 'Error') {
                          return Icon(
                            Icons.error_outline,
                            size: dz * 0.1,
                            color: Colors.red,
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return Stack(
                            children: [
                              withBlurBackground(snapshot.data),
                              Center(
                                child: CircleAvatar(
                                  radius: dz * 0.1,
                                  backgroundImage: NetworkImage(snapshot.data!),
                                ),
                              ),
                            ],
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
                ],
              ),
            ),
            InfoData(
              personId: widget.personId,
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
              image: NetworkImage(imageUrl),
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
}
