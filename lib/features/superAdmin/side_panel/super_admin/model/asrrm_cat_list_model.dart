// models/asram_model.dart

import 'dart:convert';

// Helper function to decode a JSON string into an AsramListModel object
AsramListModel asramListModelFromJson(String str) =>
    AsramListModel.fromJson(json.decode(str));

// Helper function to encode an AsramListModel object into a JSON string
String asramListModelToJson(AsramListModel data) => json.encode(data.toJson());

/// Represents the entire API response structure.
class AsramListModel {
  final Meta? meta;
  final List<AsramData>? data;

  AsramListModel({
    this.meta,
    this.data,
  });

  /// Creates an AsramListModel from a JSON map.
  /// This factory is more robust and ensures type safety during parsing.
  factory AsramListModel.fromJson(Map<String, dynamic> json) {
    List<AsramData> dataList = [];

    // Check if 'data' exists and is a List before trying to parse it
    if (json['data'] != null && json['data'] is List) {
      // Explicitly cast the list and its items to ensure type safety
      dataList = (json['data'] as List<dynamic>)
          .map((item) => AsramData.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return AsramListModel(
      meta: json["meta"] == null
          ? null
          : Meta.fromJson(json["meta"] as Map<String, dynamic>),
      data: dataList,
    );
  }

  /// Converts the AsramListModel object to a JSON map.
  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

/// Represents a single Ashram's data.
class AsramData {
  final String? id;
  final String? name;
  final String? location;

  AsramData({
    this.id,
    this.name,
    this.location,
  });

  /// Creates an AsramData object from a JSON map.
  factory AsramData.fromJson(Map<String, dynamic> json) => AsramData(
        id: json["_id"],
        name: json["name"],
        location: json["location"],
      );

  /// Converts the AsramData object to a JSON map.
  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "location": location,
      };
}

/// Represents the metadata of the API response.
class Meta {
  final String? displayMessage;
  final int? statusCode;
  final String? status;

  Meta({
    this.displayMessage,
    this.statusCode,
    this.status,
  });

  /// Creates a Meta object from a JSON map.
  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        displayMessage: json["displayMessage"],
        statusCode: json["statusCode"],
        status: json["status"],
      );

  /// Converts the Meta object to a JSON map.
  Map<String, dynamic> toJson() => {
        "displayMessage": displayMessage,
        "statusCode": statusCode,
        "status": status,
      };
}
