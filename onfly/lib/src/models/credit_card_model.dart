import 'package:onfly/src/models/transactions_model.dart';

class CreditCardDTO {
  late String? id;
  late String flag;
  late String userEmail;
  late List<TransactionsDTO> transactions;

  CreditCardDTO({
    this.id,
    required this.flag,
    List<TransactionsDTO>? transactions,
    required this.userEmail,
  }) : transactions = transactions ?? []; 

  CreditCardDTO.fromJson(Map<String, dynamic> json, String idDoc) {
    id = idDoc;
    flag = json["flag"] ?? '';
    userEmail = json["userEmail"] ?? '';
    var transactionsList = json["transactions"] as List<dynamic>;
    transactions = transactionsList
        .map((transaction) => TransactionsDTO.fromJson(transaction))
        .cast<TransactionsDTO>()
        .toList();
  }

  Map<String, dynamic> toJson() => {
        'flag': flag,
        'userEmail': userEmail,
        'transactions': transactions.map((transaction) => transaction.toJson()).toList(),
      };
}
