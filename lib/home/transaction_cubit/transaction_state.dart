part of 'transaction_cubit.dart';

class TransactionState {
  GlobalKey<FormState> formKey;
  int? stockId;
  DateTime? time;
  double? amount;
  String? amountString;
  Stock? dropdownValue;
  TransactionEnum? transactionEnum;
  List<Stock> stocks;
  String error;

//<editor-fold desc="Data Methods">

  TransactionState({
    required this.formKey,
    this.stockId,
    this.time,
    this.amount,
    this.amountString,
    this.dropdownValue,
    this.transactionEnum,
    required this.stocks,
    required this.error,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionState &&
          runtimeType == other.runtimeType &&
          formKey == other.formKey &&
          stockId == other.stockId &&
          time == other.time &&
          amount == other.amount &&
          amountString == other.amountString &&
          dropdownValue == other.dropdownValue &&
          transactionEnum == other.transactionEnum &&
          stocks == other.stocks &&
          error == other.error);

  @override
  int get hashCode =>
      formKey.hashCode ^
      stockId.hashCode ^
      time.hashCode ^
      amount.hashCode ^
      amountString.hashCode ^
      dropdownValue.hashCode ^
      transactionEnum.hashCode ^
      stocks.hashCode ^
      error.hashCode;

  @override
  String toString() {
    return 'TransactionState{' +
        ' formKey: $formKey,' +
        ' stockId: $stockId,' +
        ' time: $time,' +
        ' amount: $amount,' +
        ' amountString: $amountString,' +
        ' dropdownValue: $dropdownValue,' +
        ' transactionEnum: $transactionEnum,' +
        ' stocks: $stocks,' +
        ' error: $error,' +
        '}';
  }

  TransactionState copyWith({
    GlobalKey<FormState>? formKey,
    int? stockId,
    DateTime? time,
    double? amount,
    String? amountString,
    Stock? dropdownValue,
    TransactionEnum? transactionEnum,
    List<Stock>? stocks,
    String? error,
  }) {
    return TransactionState(
      formKey: formKey ?? this.formKey,
      stockId: stockId ?? this.stockId,
      time: time ?? this.time,
      amount: amount ?? this.amount,
      amountString: amountString ?? this.amountString,
      dropdownValue: dropdownValue ?? this.dropdownValue,
      transactionEnum: transactionEnum ?? this.transactionEnum,
      stocks: stocks ?? this.stocks,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'formKey': this.formKey,
      'stockId': this.stockId,
      'time': this.time,
      'amount': this.amount,
      'amountString': this.amountString,
      'dropdownValue': this.dropdownValue,
      'transactionEnum': this.transactionEnum,
      'stocks': this.stocks,
      'error': this.error,
    };
  }

  factory TransactionState.fromMap(Map<String, dynamic> map) {
    return TransactionState(
      formKey: map['formKey'] as GlobalKey<FormState>,
      stockId: map['stockId'] as int,
      time: map['time'] as DateTime,
      amount: map['amount'] as double,
      amountString: map['amountString'] as String,
      dropdownValue: map['dropdownValue'] as Stock,
      transactionEnum: map['transactionEnum'] as TransactionEnum,
      stocks: map['stocks'] as List<Stock>,
      error: map['error'] as String,
    );
  }

//</editor-fold>
}
