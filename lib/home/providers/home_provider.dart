import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/data/models/categorical_data.dart';
import 'package:tracal/home/providers/home_repository_provider.dart';

class DateRangeNotifier extends Notifier<DateTimeRange?> {
  @override
  DateTimeRange? build() => null;
  
  void setRange(DateTimeRange? range) => state = range;
}

final dateRangeProvider = NotifierProvider<DateRangeNotifier, DateTimeRange?>(() {
  return DateRangeNotifier();
});

final categoricalDataProvider = FutureProvider<List<CategoricalData>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  final dateRange = ref.watch(dateRangeProvider);
  
  final transactions = dateRange != null
      ? await repository.getTransactionsBetweenDates(dateRange.start, dateRange.end)
      : await repository.getTransactions();
  
  final stocks = await repository.getStocks();
  
  return CategoricalData.categoricalList(transactions: transactions, stocks: stocks);
});
