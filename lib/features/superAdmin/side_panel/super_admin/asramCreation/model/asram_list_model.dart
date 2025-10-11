// To parse this JSON data, do
//
//     final ashramList = ashramListFromJson(jsonString);

import 'dart:convert';

AshramList ashramListFromJson(String str) =>
    AshramList.fromJson(json.decode(str));

String ashramListToJson(AshramList data) => json.encode(data.toJson());

class AshramList {
  Meta meta;
  List<Datum> data;

  AshramList({
    required this.meta,
    required this.data,
  });

  factory AshramList.fromJson(Map<String, dynamic> json) => AshramList(
        meta: Meta.fromJson(json["meta"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String name;
  String location;

  Datum({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "location": location,
      };
}

class Meta {
  String displayMessage;
  int statusCode;
  String status;

  Meta({
    required this.displayMessage,
    required this.statusCode,
    required this.status,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        displayMessage: json["displayMessage"],
        statusCode: json["statusCode"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "displayMessage": displayMessage,
        "statusCode": statusCode,
        "status": status,
      };
}
