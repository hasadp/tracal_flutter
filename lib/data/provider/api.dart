import '../database/database.dart';

abstract class Api {
  Future<List<Transaction>> getTransactions(
      DateTime startDate, DateTime endDate, String stockName, int? limit);

  Future<List<Transaction>> getAllTransactions(int limit, int page);
  Future<void> addTransaction(Transaction transaction);

  Future<void> addStock(Stock stock);

  Future<void> editTransaction(Transaction transaction);

  Future<List<Stock>> getStocks();
}
