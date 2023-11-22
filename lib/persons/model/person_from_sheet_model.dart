// ignore_for_file: public_member_api_docs, sort_constructors_first
class PersonFromSheetModel {
  final String callsign;
  final String name;
  final String city;
  final String state;
  final String country;
  PersonFromSheetModel({
    required this.callsign,
    required this.name,
    required this.city,
    required this.state,
    required this.country,
  });

  factory PersonFromSheetModel.fromMap(Map<String, dynamic> map) {
    return PersonFromSheetModel(
      callsign: map['callsign'] as String,
      name: map['name'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
    );
  }

  @override
  String toString() {
    return 'PersonFromSheetModel(callsign: $callsign, name: $name, city: $city, state: $state, country: $country)';
  }
}
