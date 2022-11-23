import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:tracal/home/widgets/categorical_data.dart';

import '../../core/data/const.dart';

class CategoricalTransactionTable extends StatelessWidget {
  final CategoricalData data;

  const CategoricalTransactionTable(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Spacer(),
            Text('${data.stockName} (${data.stockAbbr})',
                style: Theme.of(context).textTheme.headlineSmall),
            const Spacer()
          ],
        ),
        DataTable(columns: const [
          DataColumn(label: Text(ColumnFields.date)),
          DataColumn(label: Text(ColumnFields.buyQty)),
          DataColumn(label: Text(ColumnFields.sellQty)),
          DataColumn(label: Text(ColumnFields.price)),
          DataColumn(label: Text(ColumnFields.buyAmount)),
          DataColumn(label: Text(ColumnFields.sellAmount)),
          DataColumn(label: Text(ColumnFields.brokerage)),
          DataColumn(label: Text(ColumnFields.cvt)),
          DataColumn(label: Text(ColumnFields.wht)),
          DataColumn(label: Text(ColumnFields.fed)),
          DataColumn(label: Text(ColumnFields.net)),
        ], rows: [
          ...List<DataRow>.generate(
              data.transactions.length,
              (index) => DataRow(cells: [
                    DataCell(Text(formatDate(data.transactions[index].date,
                        [mm, '-', dd, '-', yyyy]))),
                    DataCell(Text(data.transactions[index].type == 'B'
                        ? data.transactions[index].quantity.toString()
                        : '')),
                    DataCell(Text(data.transactions[index].type == 'S'
                        ? data.transactions[index].quantity.toString()
                        : '')),
                    DataCell(Text(data.transactions[index].price.toString())),
                    DataCell(Text(data.transactions[index].type == 'B'
                        ? (data.transactions[index].quantity *
                                data.transactions[index].price)
                            .toString()
                        : '')),
                    DataCell(Text(data.transactions[index].type == 'S'
                        ? (data.transactions[index].quantity *
                                data.transactions[index].price)
                            .toString()
                        : '')),
                    DataCell(
                        Text(data.transactions[index].brokerage.toString())),
                    DataCell(Text(data.transactions[index].cvt.toString())),
                    DataCell(Text(data.transactions[index].wht.toString())),
                    DataCell(Text(data.transactions[index].fed.toString())),
                    DataCell(Text(data.transactions[index].net.toString())),
                  ])),
          DataRow(cells: [
            const DataCell(
              Text('Total'),
            ),
            DataCell(Text(data.buyQty.toString())),
            DataCell(Text(data.sellQty.toString())),
            const DataCell(
              Text(''),
            ),
            DataCell(Text(data.buyAmount.toString())),
            DataCell(Text(data.sellAmount.toString())),
            DataCell(Text(data.brokerage.toString())),
            DataCell(Text(data.cvt.toString())),
            DataCell(Text(data.wht.toString())),
            DataCell(Text(data.fed.toString())),
            DataCell(Text(data.net.toString()))
          ])
        ]),
      ],
    );
  }
}
