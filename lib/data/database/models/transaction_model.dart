import 'package:drift/drift.dart';

import './stock_model.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get stockId => integer().references(Stocks, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get quantity => integer()();
  RealColumn get price => real()();
  RealColumn get brokerage => real()();
  RealColumn get wht => real()();
  RealColumn get cvt => real()();
  RealColumn get fed => real()();
  RealColumn get net => real()();
  TextColumn get type => text().withLength(max: 8)();
}
