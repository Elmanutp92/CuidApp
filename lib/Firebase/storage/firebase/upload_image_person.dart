import 'dart:io';

import 'package:cuida_app/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';

Future<String> uploadImagePerson(
    File image, String personId, String userName, String userId, context) async {
  try {
    // Seleccionar la calidad y ancho deseados para la compresión
    const int quality = 40;
    const int targetWidth = 400;

    // Crear una copia de la imagen original para realizar operaciones de compresión
    File compressedImage = await compressImage(image, quality, targetWidth);

    // Crear un nombre de archivo único
    final String fileName = '$userName-$userId';

    // Obtener la referencia a Firebase Storage
    final Reference imageRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(personId)
        .child(fileName);

    // Subir la imagen comprimida a Firebase Storage
    final UploadTask uploadTask = imageRef.putFile(compressedImage);

    // Esperar a que la tarea de carga se complete
    final TaskSnapshot snapshot = await uploadTask;

    if (snapshot.state == TaskState.success) {
      final player = AudioPlayer();
      player.play(AssetSource('sound.mp3'));
      final downloadURL = await snapshot.ref.getDownloadURL();


      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));

      return downloadURL;
    } else {
      final player = AudioPlayer();
      player.play(AssetSource('error.mp3'));
      return 'Error';
    }
  } catch (e) {
    final player = AudioPlayer();
    player.play(AssetSource('error.wav'));
    return 'Error';
  }
}

Future<File> compressImage(File imageFile, int quality, int targetWidth) async {
  try {
    // Decodificar la imagen
    img.Image originalImage =
        img.decodeImage(imageFile.readAsBytesSync())!;

    // Redimensionar la imagen
    img.Image resizedImage = img.copyResize(originalImage, width: targetWidth);

    // Crear un nuevo archivo para la imagen comprimida
    File compressedImage = File(
        '${imageFile.path.substring(0, imageFile.path.lastIndexOf('/'))}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg');

    // Codificar la imagen como bytes con la calidad especificada
    compressedImage
        .writeAsBytesSync(img.encodeJpg(resizedImage, quality: quality));

    return compressedImage;
  } catch (e) {
    throw Exception('Error al comprimir la imagen: $e');
  }
}
