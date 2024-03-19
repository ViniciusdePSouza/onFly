import 'package:flutter_test/flutter_test.dart';
import 'package:onfly/src/models/transactions_model.dart';

void main() {
  group('Transactions Test Model', () {
    test('Should convert correctly to json', () {
      final Map<String, dynamic> json = {
        'description': 'Test description',
        'value': '3000'
      };

      final TransactionsDTO transaction = TransactionsDTO.fromJson(json);

      expect(transaction.description, 'Test description');
      expect(transaction.value, '3000');
    });
  });
}
