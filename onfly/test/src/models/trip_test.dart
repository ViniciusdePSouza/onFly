import 'package:flutter_test/flutter_test.dart';
import 'package:onfly/src/models/trip.dart';

void main() {
  group('Trip Model Test', () {
    test('Trip model Tets: Should be instantiated correctly ', () {
      DateTime departureDateMOCK = DateTime.now();
      DateTime returnDateMOCK = DateTime.now();
      DateTime boardingHourMOCK = DateTime.now();

      final tripObj = TripDTO(
          destinationCity: 'BH',
          airCompany: 'LATAM',
          boardingPass: 'B-90',
          ticketPrice: 1600,
          checkedBags: 6,
          passengers: 2,
          tripDescription: 'Business trip',
          departureDate: departureDateMOCK,
          returnDate: returnDateMOCK,
          boardingHour: boardingHourMOCK,
          userEmail: 'email@email.com');

          expect(tripObj.destinationCity, 'BH');
          expect(tripObj.airCompany, 'LATAM');
          expect(tripObj.boardingPass, 'B-90');
          expect(tripObj.ticketPrice, 1600);
          expect(tripObj.checkedBags, 6);
          expect(tripObj.passengers, 2);
          expect(tripObj.tripDescription, 'Business trip');
          expect(tripObj.departureDate, departureDateMOCK);
          expect(tripObj.returnDate, returnDateMOCK);
          expect(tripObj.boardingHour, boardingHourMOCK);
          expect(tripObj.userEmail, 'email@email.com');
    });
  });
}
