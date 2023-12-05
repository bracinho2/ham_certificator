import 'dart:convert';

import '../../core/enums/event_type_enum.dart';

class EventModel {
  EventModel({
    required this.uid,
    required this.name,
    required this.description,
    required this.owner,
    required this.location,
    required this.type,
    required this.startAt,
    required this.endAt,
    required this.city,
    required this.state,
    required this.country,
    required this.imageUrl,
    required this.hasAvailableCertificates,
    required this.hasPageDetails,
    required this.price,
    required this.language,
    required this.contact,
    required this.hasCertification,
  });

  final String uid;
  final String name;
  final String description;
  final String owner;
  final String location;
  final EventTypeEnum type;
  final DateTime startAt;
  final DateTime endAt;
  final String city;
  final String state;
  final String country;
  final String imageUrl;
  final bool hasAvailableCertificates;
  final bool hasPageDetails;
  final String price;
  final String language;
  final String contact;
  final bool hasCertification;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'description': description,
      'owner': owner,
      'location': location,
      'type': type.toString(),
      'start_at': startAt.millisecondsSinceEpoch,
      'end_at': endAt.millisecondsSinceEpoch,
      'city': city,
      'state': state,
      'country': country,
      'image_url': imageUrl,
      'has_available_certificates': hasAvailableCertificates,
      'has_page_details': hasPageDetails,
      'price': price,
      'language': language,
      'contact': contact,
      'hasCertification': hasCertification,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      uid: map['uid'],
      name: map['name'],
      description: map['description'],
      owner: map['owner'],
      location: map['location'],
      type: EventTypeEnum.fromString(map['type']),
      startAt: DateTime.fromMillisecondsSinceEpoch(map['start_at']),
      endAt: DateTime.fromMillisecondsSinceEpoch(map['end_at']),
      city: map['city'],
      state: map['state'],
      country: map['country'],
      imageUrl: map['image_url'],
      hasAvailableCertificates: map['has_available_certificates'],
      hasPageDetails: map['has_page_details'],
      price: map['price'],
      language: map['language'],
      contact: map['contact'],
      hasCertification: map['has_certification'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventModel(uid: $uid, name: $name, description: $description, type: $type, startAt: $startAt, endAt: $endAt, city: $city, state: $state, country: $country)';
  }
}
