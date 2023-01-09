// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  int? id;
  int stockId;
  DateTime date;
  double amount;
  int type; // 0 for sell and 1 for buy
  Transaction({
    this.id,
    required this.stockId,
    required this.date,
    required this.amount,
    required this.type,
  });

  Transaction copyWith({
    int? id,
    int? stockId,
    DateTime? date,
    double? amount,
    int? type,
  }) {
    return Transaction(
      id: id ?? this.id,
      stockId: stockId ?? this.stockId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stockId': stockId,
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
      'type': type,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] != null ? map['id'] as int : null,
      stockId: map['stockId'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      amount: map['amount'] as double,
      type: map['type'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, stockId: $stockId, date: $date, amount: $amount, type: $type)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.stockId == stockId &&
        other.date == date &&
        other.amount == amount &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        stockId.hashCode ^
        date.hashCode ^
        amount.hashCode ^
        type.hashCode;
  }
}
