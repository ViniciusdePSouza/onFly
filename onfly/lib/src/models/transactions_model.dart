class TransactionsDTO {
  late String description;
  late dynamic value;

  TransactionsDTO({required this.description, required this.value});

  Map<String, dynamic> toJson() => {'description': description, 'value': value};

  TransactionsDTO.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    value = json['value'] is String
        ? json['value']
        : json['value']
            .toString(); 
  }
}
