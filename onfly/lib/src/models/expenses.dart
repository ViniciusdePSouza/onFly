class ExpenseDTO {
  late String description;
  late String expenseValue;

  ExpenseDTO({required this.description, required this.expenseValue});
  
  Map<String, dynamic> toJson() => {
    'description': description,
    'expenseValue': expenseValue
  };

  ExpenseDTO.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    expenseValue = json['expenseValue'];
  }
}
