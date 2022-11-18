import 'package:tracal/data/provider/local_api.dart';

import '../data/database/database.dart';

class HomeRepository {
  final api = LocalApi();

  Future<void> addStock(Stock stock) async => await api.addStock(stock);

  Future<List<Stock>> getStocks() async => await api.getStocks();
}
