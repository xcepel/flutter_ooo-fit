import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImage(String imagePath) async {
  final storageRef = FirebaseStorage.instance.ref();

  final name = DateTime.now().millisecondsSinceEpoch.toString();
  final destination = storageRef.child(name);

  if (!File(imagePath).existsSync()) {
    return null;
  }

  try {
    final uploadTask = await destination.putFile(File(imagePath));

    if (uploadTask.state == TaskState.success) {
      return name;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<String?> getImageDownloadURL(String path) async {
  final ref = FirebaseStorage.instance.ref().child(path);
  try {
    return await ref.getDownloadURL();
  } catch (e) {
    return null;
  }
}

Future<void> deleteImage(String path) async {
  final ref = FirebaseStorage.instance.ref().child(path);
  await ref.delete();
}
