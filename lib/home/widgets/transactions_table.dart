import 'package:data_table_2/data_table_2.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:tracal/data/database/database.dart';

abstract class ColumnFields {
  static const stockName = 'Stock';
  static const stockAbbr = 'Abbr';
  static const date = 'Date';
  static const type = 'Type';
  static const amount = 'Amount';
}

class TransactionsTable extends StatelessWidget {
  final List<Transaction> transactions;
  final List<Stock> stocks;

  const TransactionsTable(this.transactions, this.stocks, {Key? key})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columns: const [
        DataColumn(label: Text(ColumnFields.stockName)),
        DataColumn(label: Text(ColumnFields.stockAbbr)),
        DataColumn(label: Text(ColumnFields.date)),
        DataColumn(label: Text(ColumnFields.type)),
        DataColumn(label: Text(ColumnFields.amount)),
      ],
      rows: List<DataRow>.generate(
          transactions.length,
          (index) => DataRow(cells: [
                DataCell(
                    Text(getStockName(stocks, transactions[index].stockId))),
                DataCell(
                    Text(getStockAbbr(stocks, transactions[index].stockId))),
                DataCell(Text(formatDate(
                    transactions[index].date, [mm, '-', dd, '-', yyyy]))),
                DataCell(Text(transactions[index].type)),
                DataCell(Text(transactions[index].amount.toString())),
              ])),
    );
  }
}
