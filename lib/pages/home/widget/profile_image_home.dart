import 'dart:io';

import 'package:cuida_app/Firebase/storage/get_image_profile.dart';

import 'package:cuida_app/pages/profile_page/profile_page2.dart';
import 'package:cuida_app/pages/profile_page/widget/profile_image.dart';

import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ProfileImageHome extends StatefulWidget {
  const ProfileImageHome({
    Key? key,
    required this.wzo,
    required this.hzo,
    required this.border,
    required this.isHome,
  }) : super(key: key);

  final double wzo;
  final double hzo;
  final bool border;
  final bool isHome;

  @override
  _ProfileImageHomeState createState() => _ProfileImageHomeState();
}

class _ProfileImageHomeState extends State<ProfileImageHome> {
  final User? user = FirebaseAuth.instance.currentUser;
  String userName = '';
  String userId = '';

   String? urlImage = '';
  File? imageProfile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
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

    return GestureDetector(
      onTap: widget.isHome
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage2(),
                ),
              );
            }
          : ()async {
                    await uploadImageFile(context, setImage, urlImage.toString(), false);
                  },
      child: StreamBuilder<String>(
        stream: getUrlImageProfile(
            userId, userName
        ),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError || snapshot.data == 'Error') {
            return Icon(
              Icons.error_outline,
              size: dz * 0.1,
              color: Colors.red,
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return !widget.border
                ? notBorder(snapshot.data!, wz * widget.wzo, hz * widget.hzo)
                : withBorder(snapshot.data!, wz * widget.wzo, hz * widget.hzo);
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 widget.isHome ? Text('Perfil ', style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: dz * 0.015,
                ),
                ) : const SizedBox(),
                Column(
                  children: [
                    Icon(
                     !widget.isHome ? Iconsax.additem: Iconsax.user,
                      size: widget.isHome ?  dz * 0.04 : dz * 0.16,
                      color: Colors.grey,
                    ),
                    !widget.isHome ? Text('Agregar foto ', style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: dz * 0.015,
                    )): const SizedBox(),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget notBorder(image, wt, ht) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipOval(
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            image,
            width: wt,
            height: ht,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget withBorder(image, wt, ht) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: const Border.fromBorderSide(
            BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipOval(
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            image,
            width: wt,
            height: ht,
            fit: BoxFit.cover,
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
