import 'dart:io';

import 'package:cuida_app/Firebase/storage/get_image_profile.dart';
import 'package:cuida_app/pages/profile_page/widget/profile_image.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardProfile extends StatefulWidget {
  const CardProfile({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.metaData,
  });
  final String userName;
  final String userEmail;
  final String metaData;

  @override
  State<CardProfile> createState() => _CardProfileState();
}

class _CardProfileState extends State<CardProfile> {
  String? urlImage = '';
  File? imageProfile;
  String userName = '';
  String userId = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
      
      } else {
        setState(() {
          userName = user.displayName.toString();
          userId = user.uid.toString();
        });
      }
    });
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;
    return SizedBox(
      width: wz * 0.99,
      height: hz * 0.15,
      child: Card(
        color: AppColors.primaryColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 12,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    await uploadImageFile(
                        context, setImage, urlImage.toString(), false);
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<String?>(
                        future: getUrlImageProfile(userId, userName),
                        builder: (BuildContext context,
                            AsyncSnapshot<String?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Icon(
                              Icons.error_outline,
                              size: dz * 0.1,
                              color: Colors.red,
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            return ClipOval(
                              child: Image.network(
                                snapshot.data!,
                                width: wz * 0.2,
                                height: wz * 0.2,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            return Container(
                              width: wz * 0.17,
                              decoration: const BoxDecoration(
                                color: AppColors.backgroundColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: dz * 0.05,
                                color: AppColors.textColor,
                              ),
                            );
                          }
                        },
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre: ${widget.userName}',
                      style: GoogleFonts.poppins(
                        fontSize: dz * 0.015,
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      'Email: ${widget.userEmail}',
                      style: GoogleFonts.poppins(
                        fontSize: dz * 0.015,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setImage(image) {
    setState(() {
      imageProfile = File(image);
    });
  }
}
