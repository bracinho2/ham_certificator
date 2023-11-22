import 'dart:convert';

class PersonModel {
  PersonModel({
    required this.uid,
    required this.callsign,
    required this.name,
    required this.city,
    required this.state,
    required this.country,
    required this.email,
    required this.phone,
  });
  final String uid;
  final String callsign;
  final String name;
  final String city;
  final String state;
  final String country;
  final String email;
  final String phone;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'callsign': callsign,
      'name': name,
      'city': city,
      'state': state,
      'country': country,
      'email': email,
      'phone': phone,
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
      uid: map['uid'],
      callsign: map['callsign'] ?? '',
      name: map['name'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String source) =>
      PersonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PersonModel(uid: $uid, callsign: $callsign, name: $name, city: $city, state: $state, country: $country, email: $email, phone: $phone)';
  }
}
