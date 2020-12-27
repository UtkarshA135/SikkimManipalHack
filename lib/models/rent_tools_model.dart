import 'dart:convert';

class RentToolsModel {
  RentToolsModel({
    this.toolImage,
    this.toolName,
    this.toolDescription,
    this.toolType,
    this.toolPricePerDay,
    this.available,
    this.ownerContactInfo,
    this.currentLocation,
  });

  String toolImage;
  String toolName;
  String toolDescription;
  String toolType;
  String toolPricePerDay;
  bool available;
  String ownerContactInfo;
  String currentLocation;

  factory RentToolsModel.fromRawJson(String str) =>
      RentToolsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RentToolsModel.fromJson(Map<String, dynamic> json) => RentToolsModel(
        toolImage: json["toolImage"],
        toolName: json["toolName"],
        toolDescription: json["toolDescription"],
        toolType: json["toolType"],
        toolPricePerDay: json["toolPricePerDay"],
        available: json["available"],
        ownerContactInfo: json["ownerContactInfo"],
        currentLocation: json["currentLocation"],
      );

  Map<String, dynamic> toJson() => {
        "toolImage": toolImage,
        "toolName": toolName,
        "toolDescription": toolDescription,
        "toolType": toolType,
        "toolPricePerDay": toolPricePerDay,
        "available": available,
        "ownerContactInfo": ownerContactInfo,
        "currentLocation": currentLocation
      };
}
