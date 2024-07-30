import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      String childName, XFile file, bool isPost) async {
    Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putFile(File(file.path));

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<List<String>> uploadImages(List<XFile?> images) async {
    List<String> downloadUrls = [];

    await Future.forEach(images, (image) async {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('olxfiles')
          .child(const Uuid().v1());
      final UploadTask uploadTask = ref.putFile(File(image!.path));
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      final url = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(url);
    });

    return downloadUrls;
  }
}
