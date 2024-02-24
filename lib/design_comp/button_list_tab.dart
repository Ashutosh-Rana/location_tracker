import 'package:flutter/material.dart';
import 'package:location_tracker/backend/services/location_service.dart';
import 'package:location_tracker/backend/providers/location_provider.dart';
import 'package:location_tracker/design_comp/popup.dart';
import 'package:location_tracker/design_comp/primary_button.dart';
import 'package:location_tracker/utils/app_colors.dart';
import 'package:location_tracker/utils/custom_box.dart';
import 'package:location_tracker/utils/show_notification.dart';
import 'package:location_tracker/utils/text_styles.dart';
import 'package:location_tracker/utils/toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ButtonListTab extends StatefulWidget {
  
  @override
  State<ButtonListTab> createState() => _ButtonListTabState();
}

class _ButtonListTabState extends State<ButtonListTab> {
  late LocationService locationService;
  late LocationProvider locationProvider;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    locationService = LocationService(locationProvider);
  }
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSizedBox(height: screenHeight * .02),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth * .03),
              child: Text(
                "Test App",
                style: AppTextStyles.fontSize22.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.bold),
              ),
            )),
        CustomSizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PrimaryButton(
              onPressed: () async{
                await requestLocationPermission(context);
              },
              buttonText: "Request Location Permission",
              buttonColor: AppColors.blue,
              textColor: AppColors.white,
            ),
            PrimaryButton(
              onPressed: () async{
                await requestNotificationPermission(context);
              },
              buttonText: "Request Notification Permission",
              buttonColor: AppColors.yellow,
              textColor: AppColors.black,
            ),
          ],
        ),
        CustomSizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PrimaryButton(
              onPressed: () {
                showConfirmationDialog(context, Icons.check_box,
                  "Confirm to Start Location Update", "NO", "YES", () {
                Navigator.pop(context);
              }, () async {
                await locationService.startLocationUpdates();
                Navigator.pop(context);
                showNotification("Location update started", "");
                // ToastUtils.showToast(context, "Location Update Started");
              });
              },
              buttonText: "Start Location Update",
              buttonColor: AppColors.green,
              textColor: AppColors.white,
            ),
            PrimaryButton(
              onPressed: () {},
              buttonText: "Stop Location Update",
              buttonColor: AppColors.red,
              textColor: AppColors.white,
            ),
          ],
        )
      ],
    );
  }

  Future<void> requestLocationPermission(BuildContext context) async {
    final PermissionStatus status =
        await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      ToastUtils.showToast(context, "Location permission granted");
    } else {
      ToastUtils.showToast(context, "Location permission denied");
    }
  }

  Future<void> requestNotificationPermission(BuildContext context) async {
    final PermissionStatus status = await Permission.notification.request();
    if (status == PermissionStatus.granted) {
      ToastUtils.showToast(context, "Notification permission granted");
    } else {
      ToastUtils.showToast(context, "Notification permission denied");
    }
  }
}
