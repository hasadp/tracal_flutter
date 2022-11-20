import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../core/data/const.dart';
import '../../core/utils/get_stock_details.dart';
import '../../data/database/database.dart';

class TransactionsGrid extends StatelessWidget {
  final List<Transaction> transactions;
  final List<Stock> stocks;

  const TransactionsGrid(this.transactions, this.stocks, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      columns: [
        PlutoColumn(
            title: ColumnFields.stockName,
            field: ColumnFields.stockName,
            type: PlutoColumnType.text()),
        PlutoColumn(
            title: ColumnFields.stockAbbr,
            field: ColumnFields.stockAbbr,
            type: PlutoColumnType.text()),
        PlutoColumn(
            title: ColumnFields.date,
            field: ColumnFields.date,
            type: PlutoColumnType.date()),
        PlutoColumn(
            title: ColumnFields.type,
            field: ColumnFields.type,
            type: PlutoColumnType.text()),
        PlutoColumn(
            title: ColumnFields.amount,
            field: ColumnFields.amount,
            type: PlutoColumnType.number()),
      ],
      rows: List<PlutoRow>.generate(
          transactions.length,
          (i) => PlutoRow(cells: {
                ColumnFields.stockName: PlutoCell(
                    value: getStockName(stocks, transactions[i].stockId)),
                ColumnFields.stockAbbr: PlutoCell(
                    value: getStockAbbr(stocks, transactions[i].stockId)),
                ColumnFields.date: PlutoCell(
                    value: formatDate(
                        transactions[i].date, [mm, '-', dd, '-', yyyy])),
                ColumnFields.type: PlutoCell(value: transactions[i].type),
                ColumnFields.amount:
                    PlutoCell(value: transactions[i].amount.toString()),
              })),
    );
  }
}
