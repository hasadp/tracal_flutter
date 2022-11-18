import 'package:drift/drift.dart';

class Stocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get abbr => text().withLength(max: 10).unique()();
}
