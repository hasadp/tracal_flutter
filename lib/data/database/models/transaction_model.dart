import 'package:drift/drift.dart';

import './stock_model.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stockId => integer().references(Stocks, #id)();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  TextColumn get type => text().withLength(min: 1, max: 1)();
}
