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
  final int quantity;
  final double price;
  final double brokerage;
  final double wht;
  final double cvt;
  final double fed;
  final double net;
  final String type;
  const Transaction(
      {required this.id,
      required this.stockId,
      required this.date,
      required this.quantity,
      required this.price,
      required this.brokerage,
      required this.wht,
      required this.cvt,
      required this.fed,
      required this.net,
      required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stock_id'] = Variable<int>(stockId);
    map['date'] = Variable<DateTime>(date);
    map['quantity'] = Variable<int>(quantity);
    map['price'] = Variable<double>(price);
    map['brokerage'] = Variable<double>(brokerage);
    map['wht'] = Variable<double>(wht);
    map['cvt'] = Variable<double>(cvt);
    map['fed'] = Variable<double>(fed);
    map['net'] = Variable<double>(net);
    map['type'] = Variable<String>(type);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      stockId: Value(stockId),
      date: Value(date),
      quantity: Value(quantity),
      price: Value(price),
      brokerage: Value(brokerage),
      wht: Value(wht),
      cvt: Value(cvt),
      fed: Value(fed),
      net: Value(net),
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
      quantity: serializer.fromJson<int>(json['quantity']),
      price: serializer.fromJson<double>(json['price']),
      brokerage: serializer.fromJson<double>(json['brokerage']),
      wht: serializer.fromJson<double>(json['wht']),
      cvt: serializer.fromJson<double>(json['cvt']),
      fed: serializer.fromJson<double>(json['fed']),
      net: serializer.fromJson<double>(json['net']),
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
      'quantity': serializer.toJson<int>(quantity),
      'price': serializer.toJson<double>(price),
      'brokerage': serializer.toJson<double>(brokerage),
      'wht': serializer.toJson<double>(wht),
      'cvt': serializer.toJson<double>(cvt),
      'fed': serializer.toJson<double>(fed),
      'net': serializer.toJson<double>(net),
      'type': serializer.toJson<String>(type),
    };
  }

  Transaction copyWith(
          {int? id,
          int? stockId,
          DateTime? date,
          int? quantity,
          double? price,
          double? brokerage,
          double? wht,
          double? cvt,
          double? fed,
          double? net,
          String? type}) =>
      Transaction(
        id: id ?? this.id,
        stockId: stockId ?? this.stockId,
        date: date ?? this.date,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        brokerage: brokerage ?? this.brokerage,
        wht: wht ?? this.wht,
        cvt: cvt ?? this.cvt,
        fed: fed ?? this.fed,
        net: net ?? this.net,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('stockId: $stockId, ')
          ..write('date: $date, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price, ')
          ..write('brokerage: $brokerage, ')
          ..write('wht: $wht, ')
          ..write('cvt: $cvt, ')
          ..write('fed: $fed, ')
          ..write('net: $net, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, stockId, date, quantity, price, brokerage, wht, cvt, fed, net, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.stockId == this.stockId &&
          other.date == this.date &&
          other.quantity == this.quantity &&
          other.price == this.price &&
          other.brokerage == this.brokerage &&
          other.wht == this.wht &&
          other.cvt == this.cvt &&
          other.fed == this.fed &&
          other.net == this.net &&
          other.type == this.type);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int> stockId;
  final Value<DateTime> date;
  final Value<int> quantity;
  final Value<double> price;
  final Value<double> brokerage;
  final Value<double> wht;
  final Value<double> cvt;
  final Value<double> fed;
  final Value<double> net;
  final Value<String> type;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.stockId = const Value.absent(),
    this.date = const Value.absent(),
    this.quantity = const Value.absent(),
    this.price = const Value.absent(),
    this.brokerage = const Value.absent(),
    this.wht = const Value.absent(),
    this.cvt = const Value.absent(),
    this.fed = const Value.absent(),
    this.net = const Value.absent(),
    this.type = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int stockId,
    required DateTime date,
    required int quantity,
    required double price,
    required double brokerage,
    required double wht,
    required double cvt,
    required double fed,
    required double net,
    required String type,
  })  : stockId = Value(stockId),
        date = Value(date),
        quantity = Value(quantity),
        price = Value(price),
        brokerage = Value(brokerage),
        wht = Value(wht),
        cvt = Value(cvt),
        fed = Value(fed),
        net = Value(net),
        type = Value(type);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? stockId,
    Expression<DateTime>? date,
    Expression<int>? quantity,
    Expression<double>? price,
    Expression<double>? brokerage,
    Expression<double>? wht,
    Expression<double>? cvt,
    Expression<double>? fed,
    Expression<double>? net,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stockId != null) 'stock_id': stockId,
      if (date != null) 'date': date,
      if (quantity != null) 'quantity': quantity,
      if (price != null) 'price': price,
      if (brokerage != null) 'brokerage': brokerage,
      if (wht != null) 'wht': wht,
      if (cvt != null) 'cvt': cvt,
      if (fed != null) 'fed': fed,
      if (net != null) 'net': net,
      if (type != null) 'type': type,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? stockId,
      Value<DateTime>? date,
      Value<int>? quantity,
      Value<double>? price,
      Value<double>? brokerage,
      Value<double>? wht,
      Value<double>? cvt,
      Value<double>? fed,
      Value<double>? net,
      Value<String>? type}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      stockId: stockId ?? this.stockId,
      date: date ?? this.date,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      brokerage: brokerage ?? this.brokerage,
      wht: wht ?? this.wht,
      cvt: cvt ?? this.cvt,
      fed: fed ?? this.fed,
      net: net ?? this.net,
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
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (brokerage.present) {
      map['brokerage'] = Variable<double>(brokerage.value);
    }
    if (wht.present) {
      map['wht'] = Variable<double>(wht.value);
    }
    if (cvt.present) {
      map['cvt'] = Variable<double>(cvt.value);
    }
    if (fed.present) {
      map['fed'] = Variable<double>(fed.value);
    }
    if (net.present) {
      map['net'] = Variable<double>(net.value);
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
          ..write('quantity: $quantity, ')
          ..write('price: $price, ')
          ..write('brokerage: $brokerage, ')
          ..write('wht: $wht, ')
          ..write('cvt: $cvt, ')
          ..write('fed: $fed, ')
          ..write('net: $net, ')
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
  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _brokerageMeta = const VerificationMeta('brokerage');
  @override
  late final GeneratedColumn<double> brokerage = GeneratedColumn<double>(
      'brokerage', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _whtMeta = const VerificationMeta('wht');
  @override
  late final GeneratedColumn<double> wht = GeneratedColumn<double>(
      'wht', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _cvtMeta = const VerificationMeta('cvt');
  @override
  late final GeneratedColumn<double> cvt = GeneratedColumn<double>(
      'cvt', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _fedMeta = const VerificationMeta('fed');
  @override
  late final GeneratedColumn<double> fed = GeneratedColumn<double>(
      'fed', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _netMeta = const VerificationMeta('net');
  @override
  late final GeneratedColumn<double> net = GeneratedColumn<double>(
      'net', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 8),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, stockId, date, quantity, price, brokerage, wht, cvt, fed, net, type];
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
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('brokerage')) {
      context.handle(_brokerageMeta,
          brokerage.isAcceptableOrUnknown(data['brokerage']!, _brokerageMeta));
    } else if (isInserting) {
      context.missing(_brokerageMeta);
    }
    if (data.containsKey('wht')) {
      context.handle(
          _whtMeta, wht.isAcceptableOrUnknown(data['wht']!, _whtMeta));
    } else if (isInserting) {
      context.missing(_whtMeta);
    }
    if (data.containsKey('cvt')) {
      context.handle(
          _cvtMeta, cvt.isAcceptableOrUnknown(data['cvt']!, _cvtMeta));
    } else if (isInserting) {
      context.missing(_cvtMeta);
    }
    if (data.containsKey('fed')) {
      context.handle(
          _fedMeta, fed.isAcceptableOrUnknown(data['fed']!, _fedMeta));
    } else if (isInserting) {
      context.missing(_fedMeta);
    }
    if (data.containsKey('net')) {
      context.handle(
          _netMeta, net.isAcceptableOrUnknown(data['net']!, _netMeta));
    } else if (isInserting) {
      context.missing(_netMeta);
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
      quantity: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      price: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      brokerage: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}brokerage'])!,
      wht: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}wht'])!,
      cvt: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}cvt'])!,
      fed: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}fed'])!,
      net: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}net'])!,
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
