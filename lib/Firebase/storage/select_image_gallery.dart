import 'package:image_picker/image_picker.dart';

Future<String?> getImageGallery(Function setImage) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    // Actualizar la interfaz después de tomar la foto
   setImage(image.path);
    return image.path;
  }
  return null;
}
