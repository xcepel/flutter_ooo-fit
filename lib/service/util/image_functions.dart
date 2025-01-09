import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImage(String imagePath) async {
  final storageRef = FirebaseStorage.instance.ref();

  final name = DateTime.now().millisecondsSinceEpoch.toString();
  final destination = storageRef.child(name);

  if (!File(imagePath).existsSync()) {
    print('File does not exist at the given path: $imagePath');
    return null;
  }

  try {
    final uploadTask = await destination.putFile(File(imagePath));

    if (uploadTask.state == TaskState.success) {
      try {
        return name;
      } on FirebaseException catch (e) {
        print('Error fetching download URL: ${e.code} - ${e.message}');
        return null;
      }
    } else {
      print('Upload failed: ${uploadTask.state}');
      return null;
    }
  } on FirebaseException catch (e) {
    print('FirebaseException during upload: ${e.code} - ${e.message}');
    return null;
  } catch (e) {
    print('An unexpected error occurred: $e');
    return null;
  }
}

Future<String?> getImageDownloadURL(String path) async {
  final ref = FirebaseStorage.instance.ref().child(path);
  return await ref.getDownloadURL();
}

Future<String?> deleteImage(String path) async {
  final ref = FirebaseStorage.instance.ref().child(path);
  await ref.delete();
  return null;
}
