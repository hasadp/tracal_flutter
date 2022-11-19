// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Stock extends DataClass implements Insertable<Stock> {
  final int id;
  final String name;
  final String abbr;
  const Stock({required this.id, required this.name, required this.abbr});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['abbr'] = Variable<String>(abbr);
    return map;
  }

  StocksCompanion toCompanion(bool nullToAbsent) {
    return StocksCompanion(
      id: Value(id),
      name: Value(name),
      abbr: Value(abbr),
    );
  }

  factory Stock.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Stock(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      abbr: serializer.fromJson<String>(json['abbr']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'abbr': serializer.toJson<String>(abbr),
    };
  }

  Stock copyWith({int? id, String? name, String? abbr}) => Stock(
        id: id ?? this.id,
        name: name ?? this.name,
        abbr: abbr ?? this.abbr,
      );
  @override
  String toString() {
    return (StringBuffer('Stock(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('abbr: $abbr')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, abbr);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Stock &&
          other.id == this.id &&
          other.name == this.name &&
          other.abbr == this.abbr);
}

class StocksCompanion extends UpdateCompanion<Stock> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> abbr;
  const StocksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.abbr = const Value.absent(),
  });
  StocksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String abbr,
  })  : name = Value(name),
        abbr = Value(abbr);
  static Insertable<Stock> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? abbr,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (abbr != null) 'abbr': abbr,
    });
  }

  StocksCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? abbr}) {
    return StocksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      abbr: abbr ?? this.abbr,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (abbr.present) {
      map['abbr'] = Variable<String>(abbr.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StocksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('abbr: $abbr')
          ..write(')'))
        .toString();
  }
}

class $StocksTable extends Stocks with TableInfo<$StocksTable, Stock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StocksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: 'UNIQUE');
  final VerificationMeta _abbrMeta = const VerificationMeta('abbr');
  @override
  late final GeneratedColumn<String> abbr = GeneratedColumn<String>(
      'abbr', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: 'UNIQUE');
  @override
  List<GeneratedColumn> get $columns => [id, name, abbr];
  @override
  String get aliasedName => _alias ?? 'stocks';
  @override
  String get actualTableName => 'stocks';
  @override
  VerificationContext validateIntegrity(Insertable<Stock> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('abbr')) {
      context.handle(
          _abbrMeta, abbr.isAcceptableOrUnknown(data['abbr']!, _abbrMeta));
    } else if (isInserting) {
      context.missing(_abbrMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Stock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Stock(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      abbr: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}abbr'])!,
    );
  }

  @override
  $StocksTable createAlias(String alias) {
    return $StocksTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final int stockId;
  final DateTime date;
  final double amount;
  final String type;
  const Transaction(
      {required this.id,
      required this.stockId,
      required this.date,
      required this.amount,
      required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stock_id'] = Variable<int>(stockId);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
    map['type'] = Variable<String>(type);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      stockId: Value(stockId),
      date: Value(date),
      amount: Value(amount),
      type: Value(type),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      stockId: serializer.fromJson<int>(json['stockId']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stockId': serializer.toJson<int>(stockId),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<double>(amount),
      'type': serializer.toJson<String>(type),
    };
  }

  Transaction copyWith(
          {int? id,
          int? stockId,
          DateTime? date,
          double? amount,
          String? type}) =>
      Transaction(
        id: id ?? this.id,
        stockId: stockId ?? this.stockId,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('stockId: $stockId, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, stockId, date, amount, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.stockId == this.stockId &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.type == this.type);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int> stockId;
  final Value<DateTime> date;
  final Value<double> amount;
  final Value<String> type;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.stockId = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.type = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int stockId,
    required DateTime date,
    required double amount,
    required String type,
  })  : stockId = Value(stockId),
        date = Value(date),
        amount = Value(amount),
        type = Value(type);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? stockId,
    Expression<DateTime>? date,
    Expression<double>? amount,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stockId != null) 'stock_id': stockId,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (type != null) 'type': type,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? stockId,
      Value<DateTime>? date,
      Value<double>? amount,
      Value<String>? type}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      stockId: stockId ?? this.stockId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stockId.present) {
      map['stock_id'] = Variable<int>(stockId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('stockId: $stockId, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _stockIdMeta = const VerificationMeta('stockId');
  @override
  late final GeneratedColumn<int> stockId = GeneratedColumn<int>(
      'stock_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "stocks" ("id")');
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, stockId, date, amount, type];
  @override
  String get aliasedName => _alias ?? 'transactions';
  @override
  String get actualTableName => 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('stock_id')) {
      context.handle(_stockIdMeta,
          stockId.isAcceptableOrUnknown(data['stock_id']!, _stockIdMeta));
    } else if (isInserting) {
      context.missing(_stockIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      stockId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}stock_id'])!,
      date: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      amount: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      type: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $StocksTable stocks = $StocksTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [stocks, transactions];
}
