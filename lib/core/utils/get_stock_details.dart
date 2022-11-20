import '../../data/database/database.dart';

String getStockName(List<Stock> stocks, int id) {
  for (Stock stock in stocks) {
    if (stock.id == id) {
      return stock.name;
    }
  }
  throw Exception('');
}

String getStockAbbr(List<Stock> stocks, int id) {
  for (Stock stock in stocks) {
    if (stock.id == id) {
      return stock.abbr;
    }
  }
  throw Exception('');
}
