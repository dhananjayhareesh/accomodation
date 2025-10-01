import 'package:accomodation_admin/features/counterUser/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

// Updated demo data to fit Ashram Accommodation Management context
List demoMyFiles = [
  CloudStorageInfo(
    title: "Total Rooms",
    numOfFiles: 120, // Example count
    svgSrc: "assets/icons/Documents.svg", // keep placeholder
    totalStorage: "250 Guests",
    color: primaryColor,
    percentage: 65, // occupancy %
  ),
  CloudStorageInfo(
    title: "Indian Guests",
    numOfFiles: 80,
    svgSrc: "assets/icons/google_drive.svg", // keep placeholder
    totalStorage: "80 Active",
    color: Color(0xFFFFA113),
    percentage: 70,
  ),
  CloudStorageInfo(
    title: "Foreign Guests",
    numOfFiles: 40,
    svgSrc: "assets/icons/one_drive.svg", // keep placeholder
    totalStorage: "40 Active",
    color: Color(0xFFA4CDFF),
    percentage: 30,
  ),
  CloudStorageInfo(
    title: "Pending Bookings",
    numOfFiles: 15,
    svgSrc: "assets/icons/drop_box.svg", // keep placeholder
    totalStorage: "15 Requests",
    color: Color(0xFF007EE5),
    percentage: 20,
  ),
];
