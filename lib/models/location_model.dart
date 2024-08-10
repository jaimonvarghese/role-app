
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  final String country;
  final String state;
  final String district;
  final String city;

  LocationModel({required this.country, required this.state, required this.district, required this.city});

  factory LocationModel.fromFirestore(DocumentSnapshot doc) {
    return LocationModel(
      country: doc['country'],
      state: doc['state'],
      district: doc['district'],
      city: doc['city'],
    );
  }
}
