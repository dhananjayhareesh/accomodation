import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg", // keep same icon
            title: "UPI Payments",
            amountOfFiles: "₹ 25,000",
            numOfFiles: 120,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg", // keep same icon
            title: "Card Payments",
            amountOfFiles: "₹ 18,500",
            numOfFiles: 75,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/folder.svg", // keep same icon
            title: "Cash Payments",
            amountOfFiles: "₹ 40,000",
            numOfFiles: 210,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg", // keep same icon
            title: "Other Payments",
            amountOfFiles: "₹ 5,500",
            numOfFiles: 30,
          ),
        ],
      ),
    );
  }
}
