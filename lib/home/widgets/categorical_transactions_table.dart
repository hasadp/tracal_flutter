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
          DataColumn(label: Text(ColumnFields.type)),
          DataColumn(label: Text(ColumnFields.amount)),
        ], rows: [
          ...List<DataRow>.generate(
              data.transactions.length,
              (index) => DataRow(cells: [
                    DataCell(Text(formatDate(data.transactions[index].date,
                        [mm, '-', dd, '-', yyyy]))),
                    DataCell(Text(data.transactions[index].type)),
                    DataCell(Text(
                      data.transactions[index].amount.toString(),
                      style: TextStyle(
                        color: data.transactions[index].type == 'S'
                            ? Colors.green
                            : Colors.red,
                      ),
                    )),
                  ])),
          DataRow(cells: [
            const DataCell(
              Text('Total'),
            ),
            const DataCell(
              Text(''),
            ),
            DataCell(
              Text(
                data.sum.toString(),
                style: TextStyle(
                    color: data.sum.isNegative ? Colors.red : Colors.green),
              ),
            ),
          ])
        ]),
      ],
    );
  }
}
