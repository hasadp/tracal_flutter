part of 'transaction_cubit.dart';

class TransactionState {
  GlobalKey<FormState> formKey;

  int? stockId;
  DateTime? time;
  String price;
  String qty;
  String brokerage;
  String fed;
  String cvt;
  String wht;

  Stock? dropdownValue;
  TransactionEnum? transactionEnum;
  List<Stock> stocks;
  String error;

//<editor-fold desc="Data Methods">

  TransactionState({
    required this.formKey,
    this.stockId,
    this.time,
    required this.price,
    required this.qty,
    required this.brokerage,
    required this.fed,
    required this.cvt,
    required this.wht,
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
          price == other.price &&
          qty == other.qty &&
          brokerage == other.brokerage &&
          fed == other.fed &&
          cvt == other.cvt &&
          wht == other.wht &&
          dropdownValue == other.dropdownValue &&
          transactionEnum == other.transactionEnum &&
          stocks == other.stocks &&
          error == other.error);

  @override
  int get hashCode =>
      formKey.hashCode ^
      stockId.hashCode ^
      time.hashCode ^
      price.hashCode ^
      qty.hashCode ^
      brokerage.hashCode ^
      fed.hashCode ^
      cvt.hashCode ^
      wht.hashCode ^
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
        ' price: $price,' +
        ' qty: $qty,' +
        ' brokerage: $brokerage,' +
        ' fed: $fed,' +
        ' cvt: $cvt,' +
        ' wht: $wht,' +
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
    String? price,
    String? qty,
    String? brokerage,
    String? fed,
    String? cvt,
    String? wht,
    Stock? dropdownValue,
    TransactionEnum? transactionEnum,
    List<Stock>? stocks,
    String? error,
  }) {
    return TransactionState(
      formKey: formKey ?? this.formKey,
      stockId: stockId ?? this.stockId,
      time: time ?? this.time,
      price: price ?? this.price,
      qty: qty ?? this.qty,
      brokerage: brokerage ?? this.brokerage,
      fed: fed ?? this.fed,
      cvt: cvt ?? this.cvt,
      wht: wht ?? this.wht,
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
      'price': this.price,
      'qty': this.qty,
      'brokerage': this.brokerage,
      'fed': this.fed,
      'cvt': this.cvt,
      'wht': this.wht,
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
      price: map['price'] as String,
      qty: map['qty'] as String,
      brokerage: map['brokerage'] as String,
      fed: map['fed'] as String,
      cvt: map['cvt'] as String,
      wht: map['wht'] as String,
      dropdownValue: map['dropdownValue'] as Stock,
      transactionEnum: map['transactionEnum'] as TransactionEnum,
      stocks: map['stocks'] as List<Stock>,
      error: map['error'] as String,
    );
  }

//</editor-fold>
}
