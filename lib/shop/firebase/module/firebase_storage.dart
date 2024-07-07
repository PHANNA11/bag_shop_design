import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../custom/dialog/loading.dart';

RxString selectImage = ''.obs;

class FireBaseStorageController {
  final productImagePath = '/image/';

  Future<String> uploadImageToFireStore({required File? fileImage}) async {
    RxString imageName = DateTime.now().microsecondsSinceEpoch.toString().obs;
    if (fileImage != null) {
      openLoading();
      await FirebaseStorage.instance
          .ref()
          .child(productImagePath)
          .child("${imageName.value}.webp")
          .putFile(File(fileImage.path))
          .then((p0) async {
        await downloadImage(imageName: imageName.value);
        closeLoading();
        Get.back();
      });
    }
    return '';
  }

  Future downloadImage({required String? imageName}) async {
    await FirebaseStorage.instance
        .ref()
        .child(productImagePath)
        .child('$imageName.webp')
        .getDownloadURL()
        .then((value) {
      selectImage(value);
    });
  }

// Delete Image From Firebase Storage
  Future<void> deleteImage({required String imageUrl}) async {
    openLoading();
    await FirebaseStorage.instance.refFromURL(imageUrl).delete().then((value) {
      closeLoading();
    });
  }

  // =====  Camera Image =====

  openCamera() async {
    var getImage = await ImagePicker().pickImage(source: ImageSource.camera);
    await uploadImageToFireStore(fileImage: File(getImage!.path));
  }

  openGallary() async {
    var getImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    await uploadImageToFireStore(fileImage: File(getImage!.path));
  }
}
