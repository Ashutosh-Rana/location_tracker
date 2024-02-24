import 'package:flutter/material.dart';
import 'package:location_tracker/design_comp/custom_rich_text.dart';
import 'package:location_tracker/utils/app_colors.dart';
import 'package:location_tracker/utils/custom_box.dart';
import 'package:location_tracker/utils/text_styles.dart';

class LocationCard extends StatelessWidget {
  final String requestNum;
  final String lat;
  final String long;
  final String speed;

  const LocationCard(
      {super.key,
      required this.requestNum,
      required this.lat,
      required this.long,
      required this.speed});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    return Container(
      alignment: Alignment.center,
      width: isTablet? screenWidth * .45 : screenWidth * .9,
      height: 70,
      decoration: BoxDecoration(
          color: AppColors.grey, 
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:16.0),
            child: Text(
              "Request$requestNum",
              style:
                  AppTextStyles.fontSize18.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          CustomSizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
              ),
              CustomRichText(
                prefixText: "Lat: ",
                dynamicText: lat,
                prefixColor: AppColors.primaryTextBlack,
                dynamicTextColor: AppColors.secondayTextBlack,
              ),
              SizedBox(
                width: 15,
              ),
              CustomRichText(
                prefixText: "Long: ",
                dynamicText: long,
                prefixColor: AppColors.primaryTextBlack,
                dynamicTextColor: AppColors.secondayTextBlack,
              ),
              SizedBox(
                width: 15,
              ),
              CustomRichText(
                prefixText: "Speed: ",
                dynamicText: speed,
                prefixColor: AppColors.primaryTextBlack,
                dynamicTextColor: AppColors.secondayTextBlack,
              ),
            ],
          ),
          SizedBox(height: 5,)
        ],
      ),
    );
  }
}
