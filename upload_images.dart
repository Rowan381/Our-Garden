import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Script to upload default soil type images to Firebase Storage
void main() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  // Create temp files with minimal content if they don't exist
  final clayFile = File('clay_soil.png');
  if (!await clayFile.exists()) {
    await clayFile.writeAsBytes(
        [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]); // PNG header
  }

  final sandyFile = File('sandy_soil.png');
  if (!await sandyFile.exists()) {
    await sandyFile.writeAsBytes(
        [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]); // PNG header
  }

  final siltyFile = File('silty_soil.png');
  if (!await siltyFile.exists()) {
    await siltyFile.writeAsBytes(
        [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]); // PNG header
  }

  // Upload to Firebase Storage
  final storage = FirebaseStorage.instance;

  try {
    // Upload clay soil image
    await storage.ref('defaultPhotos/claySoil.png').putFile(
          clayFile,
          SettableMetadata(contentType: 'image/png'),
        );
    print('Uploaded clay_soil.png');

    // Upload sandy soil image
    await storage.ref('defaultPhotos/sandySoil.png').putFile(
          sandyFile,
          SettableMetadata(contentType: 'image/png'),
        );
    print('Uploaded sandy_soil.png');

    // Upload silty soil image
    await storage.ref('defaultPhotos/siltySoil.png').putFile(
          siltyFile,
          SettableMetadata(contentType: 'image/png'),
        );
    print('Uploaded silty_soil.png');

    print('All files uploaded successfully!');
  } catch (e) {
    print('Error uploading files: $e');
  }
}
