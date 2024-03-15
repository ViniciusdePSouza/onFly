import 'package:onfly/src/models/expenses.dart';

class TripDTO {
  String destinationCity;
  String airCompany;
  String boardingPass;
  double ticketPrice;
  int checkedBags;
  int passengers;
  String tripDescription;
  List<ExpenseDTO>? otherExpenses;
  DateTime departureDate; 
  DateTime returnDate;
  DateTime boardingHours;
  String userEmail;

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
      required this.boardingHours,
      required this.userEmail,
      });
}
