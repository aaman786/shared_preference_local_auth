import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<FilePickerResult?> pickImage() async {
  try {
    final image = await FilePicker.platform.pickFiles(type: FileType.image);

    return image;
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}

Future<XFile?> pickImageFromCam() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    return image;
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}
