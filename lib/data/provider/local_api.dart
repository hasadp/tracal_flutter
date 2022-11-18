import 'package:drift/drift.dart';
import 'package:tracal/data/provider/api.dart';

import '../database/database.dart';

class LocalApi extends Database implements Api {
  @override
  Future<int> addStock(Stock stock) async => into(stocks)
      .insert(StocksCompanion.insert(name: stock.name, abbr: stock.abbr));

  @override
  Future<void> addTransaction(Transaction transaction) async =>
      into(transactions).insert(TransactionsCompanion.insert(
          stockId: transaction.stockId,
          times: transaction.times,
          amount: transaction.amount));

  @override
  Future<void> editTransaction(Transaction transaction) {
    // TODO: implement editTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Stock>> getStocks() async => select(stocks).get();

  @override
  Future<List<Transaction>> getTransactions(DateTime startDate,
      DateTime endDate, String stockName, int? limit) async {
    return (select(transactions)
          ..where((tbl) => tbl.times.isBetweenValues(startDate, endDate)))
        .get();
  }

  @override
  Future<List<Transaction>> getAllTransactions(int limit, int page) {
    return (select(transactions)..limit(limit, offset: limit * page)).get();
  }
}
