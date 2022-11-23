import '../../data/database/database.dart';

class CategoricalData {
  final String stockName;
  final String stockAbbr;
  final List<Transaction> transactions;
  final double net;
  final int sellQty;
  final int buyQty;
  final double sellAmount;
  final double buyAmount;
  final double brokerage;
  final double cvt;
  final double wht;
  final double fed;

  static List<CategoricalData> categoricalList(
      List<Transaction> transactions, List<Stock> stocks) {
    List<CategoricalData> listData = [];

    for (Stock stock in stocks) {
      double net = 0;
      int sellQty = 0;
      int buyQty = 0;
      double sellAmount = 0;
      double buyAmount = 0;
      double brokerage = 0;
      double cvt = 0;
      double wht = 0;
      double fed = 0;
      List<Transaction> listTransactions = [];
      for (Transaction t in transactions) {
        if (t.stockId == stock.id) {
          listTransactions.add(t);
          if (t.type == 'S') {
            sellQty += t.quantity;
            sellAmount += t.quantity * t.price;
          } else {
            buyQty += t.quantity;
            buyAmount += t.quantity * t.price;
          }
          brokerage += t.brokerage;
          cvt += t.cvt;
          wht += t.wht;
          fed += t.fed;
          net = buyAmount - sellAmount + brokerage + cvt + wht + fed;
        }
      }

      listData.add(CategoricalData(
          stockName: stock.name,
          stockAbbr: stock.abbr,
          transactions: listTransactions,
          net: net,
          sellQty: sellQty,
          buyQty: buyQty,
          sellAmount: sellAmount,
          buyAmount: buyAmount,
          brokerage: brokerage,
          cvt: cvt,
          wht: wht,
          fed: fed));
    }
    return listData;
  }

  CategoricalData({
    required this.stockName,
    required this.stockAbbr,
    required this.transactions,
    required this.net,
    required this.sellQty,
    required this.buyQty,
    required this.sellAmount,
    required this.buyAmount,
    required this.brokerage,
    required this.cvt,
    required this.wht,
    required this.fed,
  });

  @override
  String toString() {
    return 'CategoricalData{stockName: $stockName, stockAbbr: $stockAbbr, transactions: $transactions, net: $net, sellQty: $sellQty, buyQty: $buyQty, sellAmount: $sellAmount, buyAmount: $buyAmount, brokerage: $brokerage, cvt: $cvt, wht: $wht, fed: $fed}';
  }
}
