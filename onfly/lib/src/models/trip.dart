import 'package:onfly/src/models/expenses.dart';

class TripDTO {
  String destinationCity;
  double ticketPrice;
  int checkedBags;
  int passengers;
  String tripDescription;
  List<ExpenseDTO>? otherExpenses;
  DateTime departureDate; 
  DateTime returnDate;
  String userEmail;

  TripDTO(
      {required this.destinationCity,
      required this.ticketPrice,
      required this.checkedBags,
      required this.passengers,
      required this.tripDescription,
      this.otherExpenses,
      required this.departureDate,
      required this.returnDate,
      required this.userEmail,
      });
}
