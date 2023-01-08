enum TransactionEnum {
  sell,
  buy;

  String get type {
    if (this == TransactionEnum.sell) {
      return 'S';
    } else {
      return 'B';
    }
  }
}

enum DialogType{
  stock,
  trade,
  error
}
