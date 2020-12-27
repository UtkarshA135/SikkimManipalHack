import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'display_rent_tools.dart';
import 'display_rent_tools_ctrl.dart';

class ChoosePlace extends StatefulWidget {
  @override
  _ChoosePlaceState createState() => _ChoosePlaceState();
}

class _ChoosePlaceState extends State<ChoosePlace> {
  final logger = Logger();
  final displayRentToolsCtrl = Get.put(DisplayRentToolsCtrl());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    displayRentToolsCtrl.instituteResultList.clear();
    displayRentToolsCtrl.searchPlaceCtrl.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildInstituteSearchTextField(),
              SizedBox(
                height: 10,
              ),
              // GetBuilder<ChooseInstituteCtrl>(
              //   id: 'chooseInstitueListView',
              //   builder: (_) {
              // if (studentModel.userInstituteLocation == null ||
              //     studentModel.userInstituteLocation == "") ...[
              // (!displayRentToolsCtrl.isInstituteSelected)
              buildInstituteList(),

              // ],

              // ShowSelectedInstitute(),
              //   },
              // ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Image.asset("assets/images/powered_by_google.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildInstituteList() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        // itemCount: 5,
        itemCount: displayRentToolsCtrl.instituteResultList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.pin_drop,
                color: Colors.white,
              ),
            ),
            title: Text(displayRentToolsCtrl.instituteResultList[index]),
            onTap: () async {
              // displayRentToolsCtrl.selectInstituteFromDropdowm(
              //     displayRentToolsCtrl.instituteResultList[index]);
              displayRentToolsCtrl.currentAddress.value =
                  displayRentToolsCtrl.instituteResultList[index];
              logger.d(
                "institute selected: ${displayRentToolsCtrl.instituteResultList[index]}",
              );
              await Get.defaultDialog(
                  title: "Selected Place is : ",
                  content:
                      Text(displayRentToolsCtrl.instituteResultList[index]),
                  textConfirm: "Yep!",
                  confirmTextColor: Colors.white,
                  textCancel: "Cancle",
                  // cancelTextColor: Colors.red,
                  onConfirm: () {
                    // Navigator.of(context).pop();
                    Get.back();
                    return Navigator.of(context).pop();
                    // return Get.offAll(DisplayRentTools());
                  }
                  //  Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) => DisplayRentTools(),
                  //       ),
                  //     )
                  // onCancel:()=> Get.back(),
                  );
              // Navigator.of(context).pop();
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => DisplayRentTools(),
              //   ),
              // );
              // setState(() {
              //   displayRentToolsCtrl.isInstituteSelected = true;
              //   displayRentToolsCtrl.instituteResultList = [];
              // });
            },
          );
        },
      ),
    );
  }

  TextField buildInstituteSearchTextField() {
    // setState(() {
    //   displayRentToolsCtrl.isInstituteSelected = false;
    // });
    return TextField(
      controller: displayRentToolsCtrl.searchPlaceCtrl,
      decoration: InputDecoration(
        labelText: "Search",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
            width: 2.0,
          ),
        ),
      ),
      onChanged: (value) {
        // displayRentToolsCtrl.onTypeInSearchBox();
        if (value.isEmpty || displayRentToolsCtrl.searchPlaceCtrl.text == '') {
          setState(() {
            displayRentToolsCtrl.instituteResultList = [];
          });
        } else if (value.isNotEmpty) {
          setState(() {
            displayRentToolsCtrl.searchPlace(value);
          });
        }
      },
    );
  }
}
