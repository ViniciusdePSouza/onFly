import 'package:get/get.dart';

import 'package:onfly/src/constants/firebase.dart';
import 'package:onfly/src/models/trip.dart';

class TripController extends GetxController {
  static TripController instance = Get.find();

  RxList<TripDTO> _trips = RxList<TripDTO>([]);
  List<TripDTO> get trips => _trips.value;

  void filterTripsByCity(String city) {
    List<TripDTO> filteredTrips = _trips
        .where((trip) => trip.destinationCity.toLowerCase().contains(city.toLowerCase()))
        .toList();
    _trips.value = filteredTrips;
  }

  Future<void> listTrips(String? userEmail) async {
    _trips.value = await firebaseFirestore
        .collection("trips")
        .where('userEmail', isEqualTo: userEmail)
        .snapshots()
        .map((query) => query.docs
            .map((item) => TripDTO.fromMap(item.data(), item.id))
            .toList())
        .first;
  }

  Future<void> addTrip(TripDTO trip) async {
    firebaseFirestore.collection("trips").add(trip.toJson());
  }

  Future<void> updateTrip(TripDTO trip) async {
    await firebaseFirestore.collection('trips').doc(trip.id).set(trip.toJson());
  }

  Future<TripDTO> getTripById(String id) async {
    var snapshot = await firebaseFirestore.collection("trips").doc(id).get();
    TripDTO trip = TripDTO.fromSnapshot(snapshot, id);
    return trip;
  }
}
