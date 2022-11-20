import 'package:flutter/material.dart';

import '../../data/database/database.dart';

class StockState {
  final GlobalKey<FormState> formKey;
  final List<Transaction> transactions;
  final bool sidebarLoading;
  final bool mainLoading;
  final bool sidebarExpanded;
  final List<Stock> stocks;
  final DateTime? startDate;
  final DateTime? endDate;
  final Stock? stock;
  final String? stockName;
  final String? stockAbbr;
  final String? error;
  final Stock? dropdownValue;
  final String dateRangeString;
  final DateTimeRange? dateTimeRange;
  final bool showCategorized;

//<editor-fold desc="Data Methods">

  const StockState({
    required this.formKey,
    required this.transactions,
    required this.sidebarLoading,
    required this.mainLoading,
    required this.sidebarExpanded,
    required this.stocks,
    this.startDate,
    this.endDate,
    this.stock,
    this.stockName,
    this.stockAbbr,
    this.error,
    this.dropdownValue,
    required this.dateRangeString,
    this.dateTimeRange,
    required this.showCategorized,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockState &&
          runtimeType == other.runtimeType &&
          formKey == other.formKey &&
          transactions == other.transactions &&
          sidebarLoading == other.sidebarLoading &&
          mainLoading == other.mainLoading &&
          sidebarExpanded == other.sidebarExpanded &&
          stocks == other.stocks &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          stock == other.stock &&
          stockName == other.stockName &&
          stockAbbr == other.stockAbbr &&
          error == other.error &&
          dropdownValue == other.dropdownValue &&
          dateRangeString == other.dateRangeString &&
          dateTimeRange == other.dateTimeRange &&
          showCategorized == other.showCategorized);

  @override
  int get hashCode =>
      formKey.hashCode ^
      transactions.hashCode ^
      sidebarLoading.hashCode ^
      mainLoading.hashCode ^
      sidebarExpanded.hashCode ^
      stocks.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      stock.hashCode ^
      stockName.hashCode ^
      stockAbbr.hashCode ^
      error.hashCode ^
      dropdownValue.hashCode ^
      dateRangeString.hashCode ^
      dateTimeRange.hashCode ^
      showCategorized.hashCode;

  @override
  String toString() {
    return 'StockState{' +
        ' formKey: $formKey,' +
        ' transactions: $transactions,' +
        ' sidebarLoading: $sidebarLoading,' +
        ' mainLoading: $mainLoading,' +
        ' sidebarExpanded: $sidebarExpanded,' +
        ' stocks: $stocks,' +
        ' startDate: $startDate,' +
        ' endDate: $endDate,' +
        ' stock: $stock,' +
        ' stockName: $stockName,' +
        ' stockAbbr: $stockAbbr,' +
        ' error: $error,' +
        ' dropdownValue: $dropdownValue,' +
        ' dateRangeString: $dateRangeString,' +
        ' dateTimeRange: $dateTimeRange,' +
        ' showCategorized: $showCategorized,' +
        '}';
  }

  StockState copyWith({
    GlobalKey<FormState>? formKey,
    List<Transaction>? transactions,
    bool? sidebarLoading,
    bool? mainLoading,
    bool? sidebarExpanded,
    List<Stock>? stocks,
    DateTime? startDate,
    DateTime? endDate,
    Stock? stock,
    String? stockName,
    String? stockAbbr,
    String? error,
    Stock? dropdownValue,
    String? dateRangeString,
    DateTimeRange? dateTimeRange,
    bool? showCategorized,
  }) {
    return StockState(
      formKey: formKey ?? this.formKey,
      transactions: transactions ?? this.transactions,
      sidebarLoading: sidebarLoading ?? this.sidebarLoading,
      mainLoading: mainLoading ?? this.mainLoading,
      sidebarExpanded: sidebarExpanded ?? this.sidebarExpanded,
      stocks: stocks ?? this.stocks,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      stock: stock ?? this.stock,
      stockName: stockName ?? this.stockName,
      stockAbbr: stockAbbr ?? this.stockAbbr,
      error: error,
      dropdownValue: dropdownValue ?? this.dropdownValue,
      dateRangeString: dateRangeString ?? this.dateRangeString,
      dateTimeRange: dateTimeRange ?? this.dateTimeRange,
      showCategorized: showCategorized ?? this.showCategorized,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'formKey': this.formKey,
      'transactions': this.transactions,
      'sidebarLoading': this.sidebarLoading,
      'mainLoading': this.mainLoading,
      'sidebarExpanded': this.sidebarExpanded,
      'stocks': this.stocks,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'stock': this.stock,
      'stockName': this.stockName,
      'stockAbbr': this.stockAbbr,
      'error': this.error,
      'dropdownValue': this.dropdownValue,
      'dateRangeString': this.dateRangeString,
      'dateTimeRange': this.dateTimeRange,
      'showCategorized': this.showCategorized,
    };
  }

  factory StockState.fromMap(Map<String, dynamic> map) {
    return StockState(
      formKey: map['formKey'] as GlobalKey<FormState>,
      transactions: map['transactions'] as List<Transaction>,
      sidebarLoading: map['sidebarLoading'] as bool,
      mainLoading: map['mainLoading'] as bool,
      sidebarExpanded: map['sidebarExpanded'] as bool,
      stocks: map['stocks'] as List<Stock>,
      startDate: map['startDate'] as DateTime,
      endDate: map['endDate'] as DateTime,
      stock: map['stock'] as Stock,
      stockName: map['stockName'] as String,
      stockAbbr: map['stockAbbr'] as String,
      error: map['error'] as String,
      dropdownValue: map['dropdownValue'] as Stock,
      dateRangeString: map['dateRangeString'] as String,
      dateTimeRange: map['dateTimeRange'] as DateTimeRange,
      showCategorized: map['showCategorized'] as bool,
    );
  }

//</editor-fold>
}

class InitialStockState extends StockState {
  InitialStockState()
      : super(
            formKey: GlobalKey<FormState>(),
            sidebarExpanded: true,
            mainLoading: false,
            sidebarLoading: false,
            stocks: [],
            transactions: [],
            dateRangeString: '',
            showCategorized: true);
}
