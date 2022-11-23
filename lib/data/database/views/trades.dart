import 'package:drift/drift.dart';
import 'package:tracal/data/database/models/models.dart';

abstract class Trade extends View {
  Transactions get transactions;
  Stocks get stocks;
}
