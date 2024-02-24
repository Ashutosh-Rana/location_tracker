class LocationModel {
  final double latitude;
  final double longitude;
  final double speed;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.speed,
  });

  LocationModel.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'],
        speed = json['speed'];

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'speed': speed,
      };
}
