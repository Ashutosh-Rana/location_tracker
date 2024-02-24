import 'dart:async';
import 'dart:convert';

import 'package:location/location.dart';
import 'package:location_tracker/backend/local_database/local_store.dart';
import 'package:location_tracker/backend/models/location_model.dart';
import 'package:location_tracker/backend/providers/location_provider.dart';
import 'package:location_tracker/main.dart';

class LocationService {
  Location location = Location();
  late Timer locationUpdateTimer = Timer(Duration.zero, () {});
  late LocationProvider locationProvider;

  LocationService(this.locationProvider);

  Future<void> initLocationService() async {
    loadLocationsFromSharedPreferences();
    startLocationUpdates();
  }

  Future<void> loadLocationsFromSharedPreferences() async {
    List<String>? storedLocations =
        prefs.getStringList(LocalStore.locationList.toString());
    if (storedLocations != null) {
      locationProvider.locationList = storedLocations
          .map((locationString) =>
              LocationModel.fromJson(json.decode(locationString)))
          .toList();
    }
  }

  void storeLocationsInSharedPreferences() {
    List<String> locationStrings = locationProvider.locationList
        .map((locationModel) => json.encode(locationModel.toJson()))
        .toList();

    prefs.setStringList(LocalStore.locationList.toString(), locationStrings);
  }

  Future<void> startLocationUpdates() async {
    try {
      bool _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          print('Location services are disabled');
          return;
        }
      }

      PermissionStatus permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission != PermissionStatus.granted) {
          print('Location permission denied');
          return;
        }
      }

      // Initial location update
      getLocationUpdate();

      // Start location updates every 30 seconds
      locationUpdateTimer = Timer.periodic(Duration(seconds: 30), (timer) {
        getLocationUpdate();
      });
    } catch (e) {
      print('Error starting location updates: $e');
    }
  }

  void getLocationUpdate() {
    location.getLocation().then((LocationData currentLocation) {
      double latitude = currentLocation.latitude ?? 0.0;
      double longitude = currentLocation.longitude ?? 0.0;
      double speed = currentLocation.speed ?? 0.0;

      // Create a LocationModel instance
      LocationModel locationModel = LocationModel(
        latitude: latitude,
        longitude: longitude,
        speed: speed,
      );

      // Update the locationList in the provider
      locationProvider.locationList = [
        ...locationProvider.locationList,
        locationModel
      ];
      // Store the updated locationList in SharedPreferences
      storeLocationsInSharedPreferences();

      print('Latitude: $latitude, Longitude: $longitude, Speed: $speed');
    }).catchError((error) {
      print('Error getting location: $error');
    });
  }

  void stopLocationUpdates() {
    // Cancel the locationUpdateTimer
    if (locationUpdateTimer.isActive) {
      locationUpdateTimer.cancel();
    }
  }
}
