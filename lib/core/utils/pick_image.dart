import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

Future pickImage() async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    return file;
  }
}

Future pickVideo() async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickVideo(source: ImageSource.gallery);
  if (file != null) {
    return file;
  }
}

Future pickMultipleImage() async {
  final ImagePicker imagePicker = ImagePicker();
  final List<XFile> images = await imagePicker.pickMultiImage();
  if (images.isNotEmpty) {
    return images;
  }
}

Future pickPdf(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
  );
  final res = result!.files.first;
  return res.xFile;
}
