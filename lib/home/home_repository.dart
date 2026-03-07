import '../data/database/database.dart';
import '../data/provider/api.dart';

class HomeRepository {
  final Api api = Database.instance;

  Future<List<Transaction>> getTransactions() async =>
      await api.getAllTransactions(100, 0);

  Future<void> addStock(Stock stock) async => await api.addStock(stock);

  Future<List<Stock>> getStocks() async => await api.getStocks();

  Future<void> addTransaction(Transaction transaction) async =>
      await api.addTransaction(transaction);

  Future<List<Transaction>> getTransactionsBetweenDates(
    DateTime startDate,
    DateTime endDate,
  ) async => await api.getTransactionsBetweenDates(startDate, endDate);

  Future<List<Transaction>> getPaginatedTransactions({
    required int limit,
    required int offset,
    List<int>? stockIds,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async =>
      await api.getPaginatedTransactions(
        limit: limit,
        offset: offset,
        stockIds: stockIds,
        type: type,
        startDate: startDate,
        endDate: endDate,
      );

  Future<int> getTransactionsCount({
    List<int>? stockIds,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async =>
      await api.getTransactionsCount(
        stockIds: stockIds,
        type: type,
        startDate: startDate,
        endDate: endDate,
      );
}
