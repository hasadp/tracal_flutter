import '../../data/database/database.dart';

class StockState {
  final bool sidebarLoading;
  final bool mainLoading;
  final bool sidebarExpanded;
  List<Stock> stocks;
  final DateTime? startDate;
  final DateTime? endDate;
  final Stock? stock;
  final String? stockName;
  final String? stockAbbr;
  final String? error;

  StockState({
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
  });

  @override
  String toString() {
    return 'StockState{sidebarLoading: $sidebarLoading, mainLoading: $mainLoading, sidebarExpanded: $sidebarExpanded, stocks: $stocks, startDate: $startDate, endDate: $endDate, stock: $stock, stockName: $stockName, stockAbbr: $stockAbbr, error: $error}';
  }

  StockState copyWith({
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
  }) {
    return StockState(
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
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockState &&
          runtimeType == other.runtimeType &&
          sidebarLoading == other.sidebarLoading &&
          mainLoading == other.mainLoading &&
          sidebarExpanded == other.sidebarExpanded &&
          stocks == other.stocks &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          stock == other.stock &&
          stockName == other.stockName &&
          stockAbbr == other.stockAbbr &&
          error == other.error;

  @override
  int get hashCode =>
      sidebarLoading.hashCode ^
      mainLoading.hashCode ^
      sidebarExpanded.hashCode ^
      stocks.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      stock.hashCode ^
      stockName.hashCode ^
      stockAbbr.hashCode ^
      error.hashCode;
}

class InitialStockState extends StockState {
  InitialStockState()
      : super(
          sidebarExpanded: true,
          mainLoading: false,
          sidebarLoading: false,
          stocks: [],
        );
}
