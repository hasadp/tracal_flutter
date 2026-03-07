import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/data/database/database.dart';
import 'package:tracal/data/models/categorical_data.dart';
import 'package:tracal/home/providers/home_repository_provider.dart';

class DateRangeNotifier extends Notifier<DateTimeRange?> {
  @override
  DateTimeRange? build() => null;

  void setRange(DateTimeRange? range) => state = range;
}

final dateRangeProvider = NotifierProvider<DateRangeNotifier, DateTimeRange?>(
  DateRangeNotifier.new,
);

final categoricalDataProvider = FutureProvider<List<CategoricalData>>((
  ref,
) async {
  final repository = ref.watch(homeRepositoryProvider);
  final dateRange = ref.watch(dateRangeProvider);

  final transactions = dateRange != null
      ? await repository.getTransactionsBetweenDates(
          dateRange.start,
          dateRange.end,
        )
      : await repository.getTransactions();

  final stocks = await repository.getStocks();

  return CategoricalData.categoricalList(
    transactions: transactions,
    stocks: stocks,
  );
});

// Stocks list for dropdowns
final stocksProvider = FutureProvider<List<Stock>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.getStocks();
});

// Single Table Filters
class SelectedStocksNotifier extends Notifier<List<int>> {
  @override
  List<int> build() => [];

  void update(List<int> stocks) => state = stocks;
}

final selectedStocksProvider =
    NotifierProvider<SelectedStocksNotifier, List<int>>(
      SelectedStocksNotifier.new,
    );

class TransactionTypeNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void update(String? type) => state = type;
}

final transactionTypeProvider =
    NotifierProvider<TransactionTypeNotifier, String?>(
      TransactionTypeNotifier.new,
    );

// Pagination State
class TransactionsPageNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void update(int page) => state = page;

  void next() => state++;
  void previous() => state--;
}

final transactionsPageProvider =
    NotifierProvider<TransactionsPageNotifier, int>(
      TransactionsPageNotifier.new,
    );

class TransactionsRowsPerPageNotifier extends Notifier<int> {
  @override
  int build() => 10;

  void update(int rows) => state = rows;
}

final transactionsRowsPerPageProvider =
    NotifierProvider<TransactionsRowsPerPageNotifier, int>(
      TransactionsRowsPerPageNotifier.new,
    );

class TransactionJoined {
  final Transaction transaction;
  final Stock stock;
  TransactionJoined(this.transaction, this.stock);
}

final paginatedTransactionsProvider = FutureProvider<List<TransactionJoined>>((
  ref,
) async {
  final repository = ref.watch(homeRepositoryProvider);
  final dateRange = ref.watch(dateRangeProvider);
  final selectedStocks = ref.watch(selectedStocksProvider);
  final type = ref.watch(transactionTypeProvider);
  final page = ref.watch(transactionsPageProvider);
  final limit = ref.watch(transactionsRowsPerPageProvider);

  final transactions = await repository.getPaginatedTransactions(
    limit: limit,
    offset: page * limit,
    stockIds: selectedStocks,
    type: type,
    startDate: dateRange?.start,
    endDate: dateRange?.end,
  );

  final allStocks = await repository.getStocks();
  final stockMap = {for (var s in allStocks) s.id: s};

  return transactions
      .map((t) => TransactionJoined(t, stockMap[t.stockId]!))
      .toList();
});

final transactionsCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  final dateRange = ref.watch(dateRangeProvider);
  final selectedStocks = ref.watch(selectedStocksProvider);
  final type = ref.watch(transactionTypeProvider);

  return repository.getTransactionsCount(
    stockIds: selectedStocks,
    type: type,
    startDate: dateRange?.start,
    endDate: dateRange?.end,
  );
});
