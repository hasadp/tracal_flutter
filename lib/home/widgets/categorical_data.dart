import '../../data/database/database.dart';

class CategoricalData {
  final String stockName;
  final String stockAbbr;
  final List<Transaction> transactions;
  final double sum;

  CategoricalData(
      {required this.stockName,
      required this.stockAbbr,
      required this.transactions,
      required this.sum});
  static List<CategoricalData> categoricalList(
      List<Transaction> transactions, List<Stock> stocks) {
    List<CategoricalData> listData = [];
    for (Stock stock in stocks) {
      double sum = 0;
      List<Transaction> listTransactions = [];
      for (Transaction t in transactions) {
        if (t.stockId == stock.id) {
          listTransactions.add(t);
          if (t.type == 'S') {
            sum += t.amount;
          } else {
            sum -= t.amount;
          }
        }
      }
      listData.add(CategoricalData(
          stockName: stock.name,
          stockAbbr: stock.abbr,
          transactions: listTransactions,
          sum: sum));
    }
    return listData;
  }
}
