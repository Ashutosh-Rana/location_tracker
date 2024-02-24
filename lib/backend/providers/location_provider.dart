import 'package:flutter/material.dart';
import 'package:location_tracker/backend/models/location_model.dart';

class LocationProvider extends ChangeNotifier{
  List<LocationModel> _locationList = [];

  List<LocationModel> get locationList => _locationList;

  set locationList(List<LocationModel> newList) {
    _locationList = newList;
    notifyListeners();
  }
}