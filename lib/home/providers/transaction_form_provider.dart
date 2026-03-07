import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/core/enums/enums.dart';
import 'package:tracal/data/database/database.dart';
import 'package:tracal/home/providers/home_repository_provider.dart';
import 'package:tracal/home/providers/home_provider.dart';

class TransactionFormState {
  final GlobalKey<FormState> formKey;
  final Stock? dropdownValue;
  final TransactionEnum transactionEnum;
  final List<Stock> stocks;
  final int quantity;
  final double price;
  final double brokerage;
  final double cvt;
  final double wht;
  final double fed;
  final DateTime date;

  TransactionFormState({
    required this.formKey,
    this.dropdownValue,
    this.transactionEnum = TransactionEnum.buy,
    this.stocks = const [],
    this.quantity = 0,
    this.price = 0.0,
    this.brokerage = 0.0,
    this.cvt = 0.0,
    this.wht = 0.0,
    this.fed = 0.0,
    required this.date,
  });

  TransactionFormState copyWith({
    GlobalKey<FormState>? formKey,
    Stock? dropdownValue,
    TransactionEnum? transactionEnum,
    List<Stock>? stocks,
    int? quantity,
    double? price,
    double? brokerage,
    double? cvt,
    double? wht,
    double? fed,
    DateTime? date,
  }) {
    return TransactionFormState(
      formKey: formKey ?? this.formKey,
      dropdownValue: dropdownValue ?? this.dropdownValue,
      transactionEnum: transactionEnum ?? this.transactionEnum,
      stocks: stocks ?? this.stocks,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      brokerage: brokerage ?? this.brokerage,
      cvt: cvt ?? this.cvt,
      wht: wht ?? this.wht,
      fed: fed ?? this.fed,
      date: date ?? this.date,
    );
  }
}

class TransactionFormNotifier extends Notifier<TransactionFormState> {
  @override
  TransactionFormState build() {
    _loadStocks();
    return TransactionFormState(
      formKey: GlobalKey<FormState>(),
      date: DateTime.now(),
    );
  }

  Future<void> _loadStocks() async {
    final stocks = await ref.read(homeRepositoryProvider).getStocks();
    state = state.copyWith(stocks: stocks);
    if (stocks.isNotEmpty && state.dropdownValue == null) {
      state = state.copyWith(dropdownValue: stocks.first);
    }
  }

  void dropdownItemChanged(Stock value) {
    state = state.copyWith(dropdownValue: value);
  }

  void onTransactionTypeChanged(TransactionEnum? value) {
    if (value != null) {
      state = state.copyWith(transactionEnum: value);
    }
  }

  void onQuantityChanged(String value) {
    state = state.copyWith(quantity: int.tryParse(value) ?? 0);
  }

  void onPriceChanged(String value) {
    state = state.copyWith(price: double.tryParse(value) ?? 0.0);
  }

  void onBrokerageChanged(String value) {
    state = state.copyWith(brokerage: double.tryParse(value) ?? 0.0);
  }

  void onCVTChanged(String value) {
    state = state.copyWith(cvt: double.tryParse(value) ?? 0.0);
  }

  void onWHTChanged(String value) {
    state = state.copyWith(wht: double.tryParse(value) ?? 0.0);
  }

  void onFEDChanged(String value) {
    state = state.copyWith(fed: double.tryParse(value) ?? 0.0);
  }

  void onDateChanged(DateTime dateTime) {
    state = state.copyWith(date: dateTime);
  }

  Future<void> addTransaction() async {
    if (state.dropdownValue == null) return;

    final type = state.transactionEnum == TransactionEnum.buy ? 'B' : 'S';
    final fees = state.brokerage + state.cvt + state.wht + state.fed;
    final value = state.price * state.quantity;

    // Usually for buy net = value + fees, for sell net = value - fees
    final netValue = type == 'B' ? value + fees : value - fees;

    final transaction = Transaction(
      id: 0,
      stockId: state.dropdownValue!.id,
      date: state.date,
      type: type,
      price: state.price,
      quantity: state.quantity,
      brokerage: state.brokerage,
      cvt: state.cvt,
      wht: state.wht,
      fed: state.fed,
      net: netValue,
    );
    await ref.read(homeRepositoryProvider).addTransaction(transaction);
    ref.invalidate(categoricalDataProvider); // refresh UI
  }
}

final transactionFormProvider =
    NotifierProvider<TransactionFormNotifier, TransactionFormState>(
      TransactionFormNotifier.new,
    );
