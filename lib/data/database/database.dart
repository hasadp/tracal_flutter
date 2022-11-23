import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:tracal/data/provider/api.dart';

import './models/models.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Stocks, Transactions])
class Database extends _$Database implements Api {
  static final Database _instance = Database._();

  Database._() : super(_openConnection());

  static Database get instance => _instance;

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (Migrator m) async {
      await m.createAll();
    }, onUpgrade: (Migrator m, int from, int to) async {
      if (kDebugMode) {
        print('Database from: $from Database to: $to');
      }
      // m.deleteTable('stocks');
      //m.deleteTable('transactions');
      //m.createAll();
    });
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));

      return NativeDatabase(file, logStatements: true);
    });
  }

  @override
  Future<int> addStock(Stock stock) async => into(stocks)
      .insert(StocksCompanion.insert(name: stock.name, abbr: stock.abbr));

  @override
  Future<void> addTransaction(Transaction transaction) async =>
      into(transactions).insert(TransactionsCompanion.insert(
          brokerage: transaction.brokerage,
          wht: transaction.wht,
          cvt: transaction.cvt,
          stockId: transaction.stockId,
          date: transaction.date,
          quantity: transaction.quantity,
          type: transaction.type,
          price: transaction.price,
          net: transaction.net,
          fed: transaction.fed));

  @override
  Future<void> editTransaction(Transaction transaction) {
    // TODO: implement editTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Stock>> getStocks() async => await select(stocks).get();

  @override
  Future<List<Transaction>> getTransactionsBetweenDates(
      DateTime startDate, DateTime endDate) async {
    return ((select(transactions)..where((tbl) => tbl.date.isBetweenValues(startDate, endDate)))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]))
        .get();
  }

  @override
  Future<List<Transaction>> getAllTransactions(int limit, int page) async {
    //return (select(transactions)..limit(limit, offset: limit * page)).get();
    return await select(transactions).get();
  }
}
