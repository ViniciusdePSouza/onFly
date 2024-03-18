import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onfly/src/models/expenses.dart';

class TripDTO {
  late String? id;
  late String destinationCity;
  late String airCompany;
  late String boardingPass;
  late double ticketPrice;
  late int checkedBags;
  late int passengers;
  late String tripDescription;
  late List<ExpenseDTO>? otherExpenses = [];
  late DateTime departureDate;
  late DateTime returnDate;
  late DateTime boardingHour;
  late String userEmail;

  TripDTO(
      {required this.destinationCity,
      required this.airCompany,
      required this.boardingPass,
      required this.ticketPrice,
      required this.checkedBags,
      required this.passengers,
      required this.tripDescription,
      this.otherExpenses,
      required this.departureDate,
      required this.returnDate,
      required this.boardingHour,
      required this.userEmail,
      this.id});

  TripDTO.fromMap(Map<String, dynamic> json, String idDoc) {
    id = idDoc;
    destinationCity = json["destinationCity"] ?? '';
    airCompany = json["airCompany"] ?? '';
    if (json["boardingHour"] != null) {
      Timestamp timeStamp = json["boardingHour"];
      boardingHour = timeStamp.toDate() ?? DateTime.now();
    }
    boardingPass = json["boardingPass"] ?? '';
    checkedBags = json["checkedBags"] ?? 0;
    ticketPrice = json["ticketPrice"] ?? 0.0;
    if (json["departureDate"] != null) {
      Timestamp timeStamp = json["departureDate"];
      departureDate = timeStamp.toDate() ?? DateTime.now();
    }
    if (json["returnDate"] != null) {
      Timestamp timeStamp = json["returnDate"];
      returnDate = timeStamp.toDate() ?? DateTime.now();
    }
    if (json["otherExpenses"] != null) {
      var expensesList = json["otherExpenses"] as List<dynamic>;
      otherExpenses = expensesList
          .map((e) => ExpenseDTO.fromJson(e))
          .cast<ExpenseDTO>()
          .toList();
    }
    passengers = json["passengers"] ?? 0;
    tripDescription = json["tripDescription"] ?? '';
    userEmail = json["userEmail"] ?? '';
  }

  Map<String, dynamic> toJson() => {
        'destinationCity': destinationCity,
        'id': id,
        'airCompany': airCompany,
        'boardingHour': boardingHour,
        'boardingPass': boardingPass,
        'checkedBags': checkedBags,
        'ticketPrice': ticketPrice,
        'departureDate': departureDate,
        'returnDate': returnDate,
        'passengers': passengers,
        'tripDescription': tripDescription,
        if (otherExpenses != null)
          'otherExpenses': otherExpenses!.map((e) => e.toJson()).toList(),
        'userEmail': userEmail
      };

  TripDTO.fromSnapshot(DocumentSnapshot snapshot, String idDoc) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    id = idDoc;
    destinationCity = data["destinationCity"] ?? '';
    airCompany = data["airCompany"] ?? '';
    if (data["boardingHour"] != null) {
      Timestamp timeStamp = data["boardingHour"];
      boardingHour = timeStamp.toDate() ?? DateTime.now();
    }
    boardingPass = data["boardingPass"] ?? '';
    checkedBags = int.parse(data["checkedBags"]) ?? 0;
    ticketPrice = double.parse(data["ticketPrice"]) ?? 0.0;
    if (data["departureDate"] != null) {
      Timestamp timeStamp = data["departureDate"];
      departureDate = timeStamp.toDate() ?? DateTime.now();
    }
    if (data["boardingHour"] != null) {
      Timestamp timeStamp = data["returnDate"];
      returnDate = timeStamp.toDate() ?? DateTime.now();
    }
    passengers = int.parse(data["passengers"]) ?? 0;
    tripDescription = data["tripDescription"] ?? '';
    userEmail = data["userEmail"] ?? '';
  }
}
