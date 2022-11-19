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
}
