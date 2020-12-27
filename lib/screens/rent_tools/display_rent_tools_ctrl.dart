import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:manipalhack/models/rent_tools_model.dart';
import 'package:logger/logger.dart';
import 'package:manipalhack/screens/rent_tools/add_rent_tools_ctrl.dart';
import 'package:dio/dio.dart';

import 'display_rent_tools.dart';

class DisplayRentToolsCtrl extends GetxController {
  RentToolsModel rentToolsModel = RentToolsModel();
  final isLoading = false.obs;
  final selectedCategory = "All".obs;
  Query query;
  final logger = Logger();
  Dio dio = Dio();
  var instituteResultList = [];
  TextEditingController searchPlaceCtrl = TextEditingController();
  // String myCurrentLocation = "Katihar,Bihar,India";
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    // Get.find<AddRentToolsCtrl>().getAddressFromLatLng();
    // Get.put<AddRentToolsCtrl>(AddRentToolsCtrl()).getCurrentLocation();
    // Get.find<AddRentToolsCtrl>().getAddressFromLatLng();
    // Get.find<AddRentToolsCtrl>().getCurrentLocation();
    await getCurrentLocation();
    // rentToolsModel.currentLocation = currentAddress.value;
  }

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position currentPosition;
  final currentAddress = ''.obs;
  TextEditingController review = new TextEditingController();

  getCurrentLocation() async {
    logger.d('inside getCurrentLocation()');
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      // setState(() {
      currentPosition = position;
      // });

      getAddressFromLatLng();
    }).catchError((e) {
      logger.d(e);
    });
  }

  getAddressFromLatLng() async {
    logger.d('inside getCurrentLocation()');
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = p[0];

      // setState(() {
      // currentAddress.value =
      //     "${place.},{place.administrativeArea},${place.country}";
      currentAddress.value =
          "${place.locality}, ${place.administrativeArea}, ${place.country}";
      // });
    } catch (e) {
      logger.d(e);
    }
  }

  searchPlace(String searchText) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$searchText&type=state&key=AIzaSyCS90XB-jQMIhQbA2C9vzfWKETNaxpjWJo";
    Response response = await dio.get(url);

    var results = response.data['results'];
    instituteResultList = [];
    for (var i = 0; i < results.length; i++) {
      if (!instituteResultList.contains(results[i]['name']))
        instituteResultList.add(results[i]['formatted_address']);
    }
    // logger.d('response is: ${response.data.toString()}');
    // ignore: unnecessary_brace_in_string_interps
    logger.d('instituteResultList is: ${instituteResultList}');
  }

  // selectInstituteFromDropdowm(String selectedInstitute) {
  //   currentAddress.value = selectedInstitute;
  //   // studentModel?.userInstituteLocation = selectedInstitute;
  //   // instituteResultList = [];
  //   Get.defaultDialog(
  //     title: "Selected Place is : ",
  //     content: Text(selectedInstitute),
  //     textConfirm: "Yep!",
  //     confirmTextColor: Colors.white,
  //     textCancel: "Cancle",
  //     // cancelTextColor: Colors.red,
  //     onConfirm: () => Get.offAll(DisplayRentTools()),
  //     // onCancel:()=> Get.back(),
  //   );
  // }

  rentToolsStreams() {
    // rentToolsModel.currentLocation = currentAddress.value;
    // return Firestore.instance.collection('rentTools').document().snapshot;
    if (selectedCategory.value == "All") {
      logger.d("insie if");
      // return Firestore.instance.collection('rentTools').snapshots();
      return Firestore.instance
          .collection('rentTools')
          .where("currentLocation", isEqualTo: currentAddress.value)
          .snapshots();
    } else if (selectedCategory.value == "Tractors") {
      logger.d("insie else if selectedCategory.value Tractors");
      return Firestore.instance
          .collection('rentTools')
          .where('toolType', isEqualTo: "Tractors")
          .where("currentLocation", isEqualTo: currentAddress.value)
          .snapshots();
    } else if (selectedCategory.value == "Harvestors") {
      logger.d("insie else if Harvestors");
      return Firestore.instance
          .collection('rentTools')
          .where('toolType', isEqualTo: "Harvestors")
          .where("currentLocation", isEqualTo: currentAddress.value)
          .snapshots();
    } else if (selectedCategory.value == "Pesticides") {
      logger.d("insie else if Pesticides");
      return Firestore.instance
          .collection('rentTools')
          .where('toolType', isEqualTo: "Pesticides")
          .where("currentLocation", isEqualTo: currentAddress.value)
          .snapshots();
    } else if (selectedCategory.value == "Others") {
      logger.d("insie else if Others");
      return Firestore.instance
          .collection('rentTools')
          .where('toolType', isEqualTo: "Others")
          .where("currentLocation", isEqualTo: currentAddress.value)
          .snapshots();
    }
  }
}
