import 'dart:convert';

class ParticipationModel {
  ParticipationModel({
    required this.callsign,
    required this.name,
    required this.city,
    required this.state,
    required this.country,
  });
  final String callsign;
  final String name;
  final String city;
  final String state;
  final String country;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'callsign': callsign,
      'name': name,
      'city': city,
      'state': state,
      'country': country,
    };
  }

  factory ParticipationModel.fromMap(Map<String, dynamic> map) {
    return ParticipationModel(
      callsign: map['callsign'],
      name: map['name'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParticipationModel.fromJson(String source) =>
      ParticipationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ParticipationModel(callsign: $callsign, name: $name, city: $city, state: $state, country: $country)';
  }
}
