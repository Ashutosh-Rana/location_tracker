import 'package:flutter/material.dart';
import 'package:location_tracker/backend/services/location_service.dart';
import 'package:location_tracker/backend/providers/location_provider.dart';
import 'package:location_tracker/design_comp/button_list_mobile.dart';
import 'package:location_tracker/design_comp/button_list_tab.dart';
import 'package:location_tracker/design_comp/location_card.dart';
import 'package:location_tracker/utils/app_colors.dart';
import 'package:location_tracker/utils/custom_box.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LocationService locationService;
  late LocationProvider locationProvider;

  @override
  void initState() {
    super.initState();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      locationService = LocationService(
          Provider.of<LocationProvider>(context, listen: false));
      await locationService.loadLocationsFromSharedPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isTablet = screenWidth > 600;
    locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isTablet
                  ? CustomSizedBox(height: screenHeight * .4)
                  : CustomSizedBox(height: screenHeight * .45),
              isTablet
                  ? GridView.builder(
                      shrinkWrap: true,
                      itemCount: locationProvider.locationList.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 70, crossAxisCount: 2,
                        crossAxisSpacing: screenWidth *
                            .01, // Adjust the spacing between columns
                        mainAxisSpacing:
                            20.0, // Adjust the spacing between rows
                      ),
                      itemBuilder: (context, index) {
                        var locationModel =
                            locationProvider.locationList[index];
                        return Center(
                          child: LocationCard(
                            requestNum: "${index + 1}",
                            lat: locationModel.latitude.toStringAsFixed(3),
                            long: locationModel.longitude.toStringAsFixed(3),
                            speed: "${locationModel.speed.toStringAsFixed(2)}m",
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: locationProvider.locationList.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var locationModel =
                            locationProvider.locationList[index];
                        return Column(
                          children: [
                            LocationCard(
                              requestNum: "${index + 1}",
                              lat: locationModel.latitude.toStringAsFixed(3),
                              long: locationModel.longitude.toStringAsFixed(3),
                              speed: "${locationModel.speed.toStringAsFixed(2)}m",
                            ),
                            CustomSizedBox(height: 20)
                          ],
                        );
                      },
                    ),
            ],
          ),
        ),
        Container(
            height: isTablet ? screenHeight * .35 : screenHeight * .45,
            width: screenWidth,
            alignment: Alignment.center,
            color: AppColors.black.withOpacity(0.7),
            child: isTablet ? ButtonListTab() : ButtonListMobile()),
      ]),
    );
  }
}
