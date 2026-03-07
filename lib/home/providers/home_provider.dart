import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/data/models/categorical_data.dart';
import 'package:tracal/home/providers/home_repository_provider.dart';

class DateRangeNotifier extends Notifier<DateTimeRange?> {
  @override
  DateTimeRange? build() => null;

  void setRange(DateTimeRange? range) => state = range;
}

final dateRangeProvider = NotifierProvider<DateRangeNotifier, DateTimeRange?>(
  () {
    return DateRangeNotifier();
  },
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
final selectedStocksProvider = StateProvider<List<int>>((ref) => []);
final transactionTypeProvider = StateProvider<String?>((ref) => null);

// Pagination State
final transactionsPageProvider = StateProvider<int>((ref) => 0);
final transactionsRowsPerPageProvider = StateProvider<int>((ref) => 10);

class TransactionJoined {
  final Transaction transaction;
  final Stock stock;
  TransactionJoined(this.transaction, this.stock);
}

final paginatedTransactionsProvider = FutureProvider<List<TransactionJoined>>((ref) async {
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

  return transactions.map((t) => TransactionJoined(t, stockMap[t.stockId]!)).toList();
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
