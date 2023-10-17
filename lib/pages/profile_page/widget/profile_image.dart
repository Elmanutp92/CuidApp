import 'dart:io';

import 'package:cuida_app/Firebase/storage/firebase/upload_image_person.dart';
import 'package:cuida_app/Firebase/storage/firebase/upload_image_profile.dart';
import 'package:cuida_app/Firebase/storage/select_image_camera.dart';
import 'package:cuida_app/Firebase/storage/select_image_gallery.dart';

import 'package:cuida_app/pages/profile_page/profile_page2.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> uploadImageFile(
    context, Function setImage, String imageUrl, bool addPerson,[ String? personId]) async {
  File? localImageProfile;
  bool isLoading = false;

  void newPersonOk() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryColor,
        content: Text(
          'Persona agregada correctamente',
          style: GoogleFonts.poppins(color: AppColors.textColor),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
    Navigator.pop(context);
  }

  void newPersonFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ups, Error inesperado'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Selecciona una imagen'),
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
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
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
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.primaryColor.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                print('Subiendo imagen');
                                if (localImageProfile == null) {
                                  return;
                                } else {
                                  final subio = !addPerson
                                      ? await uploadImageProfile(
                                          localImageProfile!)
                                      : await uploadImagePerson(
                                          localImageProfile!, personId!);
                                  if (subio == 'Error') {
                                    print('Error al subir imagen');
                                  } else {
                                    print('Imagen subida correctamente');
                                    // ignore: use_build_context_synchronously
                                    !addPerson ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  const ProfilePage2()) 
                                              
                                    // ignore: use_build_context_synchronously
                                    ) :   Navigator.pop(context);
                                  }
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Subir imagen',
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                  Icon(Icons.upload_file),
                                ],
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
