import 'package:get/get.dart';
import 'package:onfly/src/constants/firebase.dart';
import 'package:onfly/src/models/credit_card_model.dart';

class CreditCardController extends GetxController {
  static CreditCardController instance = Get.find();

  RxList<CreditCardDTO> _creditCard = RxList<CreditCardDTO>([]);

  List<CreditCardDTO> get creditCard => _creditCard.value;

  Future<void> getCards(String? userEmail) async {
    _creditCard.value = await firebaseFirestore
        .collection("cards")
        .where('userEmail', isEqualTo: userEmail)
        .snapshots()
        .map((query) => query.docs
            .map((item) => CreditCardDTO.fromJson(item.data(), item.id))
            .toList())
        .first;
  }

  Future<void> addTrip(CreditCardDTO trip) async {
    firebaseFirestore.collection("trips").add(trip.toJson());
  }
}
