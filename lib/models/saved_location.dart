class SavedLocation {
  final String city;
  final String country;

  SavedLocation({required this.city, required this.country});

  factory SavedLocation.fromJson(Map<String, dynamic> json) {
    return SavedLocation(city: json['city'], country: json['country']);
  }

  Map<String, dynamic> toJson() {
    return {'city': city, 'country': country};
  }
}
