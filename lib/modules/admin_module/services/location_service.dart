import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/location_model.dart';


class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  //adding location
  Future<void> addLocation(String country, String state, String district, String city) async {
    await _firestore.collection('LocationModel').add({
      'country': country,
      'state': state,
      'district': district,
      'city': city,
    });
  }
  
  //get locations
  Stream<List<LocationModel>> getLocations() {
    return _firestore.collection('LocationModel').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => LocationModel.fromFirestore(doc)).toList();
    });
  }
}
