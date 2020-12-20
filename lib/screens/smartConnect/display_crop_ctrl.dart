import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:manipalhack/models/crop_model.dart';

class DisplayCropCtrl extends GetxController {
  CropModel cropModel = CropModel();
  final isLoading = false.obs;
  cropStream() {
    Firestore.instance.collection('crop').getDocuments();
  }
}
