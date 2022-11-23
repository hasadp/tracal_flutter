import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:tracal/data/database/database.dart';

import '../../core/data/const.dart';
import '../../core/utils/get_stock_details.dart';

class TransactionsTable extends StatelessWidget {
  final List<Transaction> transactions;
  final List<Stock> stocks;

  const TransactionsTable(this.transactions, this.stocks, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sum = 0;
    for (Transaction t in transactions) {
      if (t.type == 'S') {
        sum += t.net;
      } else {
        sum -= t.net;
      }
    }

    return DataTable(
      columns: const [
        DataColumn(label: Text(ColumnFields.stockName)),
        DataColumn(label: Text(ColumnFields.stockAbbr)),
        DataColumn(label: Text(ColumnFields.date)),
        DataColumn(label: Text(ColumnFields.brokerage)),
        DataColumn(label: Text(ColumnFields.net)),
      ],
      rows: [
        ...List<DataRow>.generate(
            transactions.length,
            (i) => DataRow(cells: [
                  DataCell(Text(getStockName(stocks, transactions[i].stockId))),
                  DataCell(Text(getStockAbbr(stocks, transactions[i].stockId))),
                  DataCell(Text(formatDate(
                      transactions[i].date, [mm, '-', dd, '-', yyyy]))),
                  DataCell(Text(transactions[i].type)),
                  DataCell(Text(
                    transactions[i].net.toString(),
                    style: TextStyle(
                        color: transactions[i].type == 'S'
                            ? Colors.green
                            : Colors.red),
                  )),
                ])),
        DataRow(cells: [
          const DataCell(Text('Total')),
          const DataCell(Text('')),
          const DataCell(Text('')),
          const DataCell(Text('')),
          DataCell(Text(
            sum.toString(),
            style: TextStyle(color: sum >= 0 ? Colors.green : Colors.red),
          )),
        ])
      ],
    );
  }
}
