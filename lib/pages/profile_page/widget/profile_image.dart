import 'dart:io';

import 'package:cuida_app/Firebase/storage/firebase/upload_image_person.dart';
import 'package:cuida_app/Firebase/storage/firebase/upload_image_profile.dart';
import 'package:cuida_app/Firebase/storage/select_image_camera.dart';
import 'package:cuida_app/Firebase/storage/select_image_gallery.dart';

import 'package:cuida_app/pages/profile_page/profile_page2.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


Future<void> uploadImageFile(
    context, Function setImage, String imageUrl, bool addPerson,
    [String? personId]) async {
  File? localImageProfile;
  bool isLoading = false;



  String userName = '';
  String userId = '';

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
     
    } else {
      userName = user.displayName.toString();
      userId = user.uid.toString();
    }
  });

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Center(child: Text('Selecciona una imagen')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  imageUrl.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primaryColor.withOpacity(0.1),
                          ),
                          child: localImageProfile == null
                              ? Icon(
                                  Icons.person,
                                  size: 100,
                                  color: AppColors.textColor.withOpacity(0.5),
                                )
                              : Image.file(localImageProfile!),
                        )
                      : imageUrl.isNotEmpty  && localImageProfile != null ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Image.file(localImageProfile!)
                        ) : const SizedBox(),
                  localImageProfile == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });

                                final imageCam = await getImageCamera(setImage);

                                setState(() {
                                  localImageProfile = File(imageCam!);
                                  isLoading = false;
                                });
                              },
                              icon: const Icon(Icons.camera_alt),
                            ),
                            IconButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });

                                final imageGal =
                                    await getImageGallery(setImage);

                                setState(() {
                                  localImageProfile = File(imageGal!);
                                  isLoading = false;
                                });
                              },
                              icon: const Icon(Icons.photo),
                            ),
                          ],
                        )
                      : isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.primaryColor),
                              ),
                            )
                          : TextButton(
                             
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                
                                if (localImageProfile == null) {
                                  return;
                                } else {
                                  final subio = !addPerson
                                      // ignore: use_build_context_synchronously
                                      ? await uploadImageProfile(
                                          localImageProfile!, userName, userId, context)
                                      // ignore: use_build_context_synchronously
                                      : await uploadImagePerson(
                                          localImageProfile!,
                                          personId!,
                                          userName,
                                          userId, context);
                                  if (subio == 'Error') {
                                   
                                  } else {
                                
                                    // ignore: use_build_context_synchronously
                                  
                                  }
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: const Text(
                                'Subir imagen',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
