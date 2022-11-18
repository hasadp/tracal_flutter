import 'package:drift/drift.dart';

import './stock_model.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stockId => integer().references(Stocks, #id)();
  DateTimeColumn get times => dateTime()();
  RealColumn get amount => real()();
}
