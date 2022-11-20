import 'package:flutter/material.dart';
import 'package:tracal/home/widgets/categorical_data.dart';
import 'package:tracal/home/widgets/categorical_transactions_table.dart';

import '../../data/database/database.dart';

class CategoricalWindows extends StatelessWidget {
  final List<Transaction> transactions;
  final List<Stock> stocks;
  const CategoricalWindows(
      {required this.transactions, required this.stocks, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoricalData> data =
        CategoricalData.categoricalList(transactions, stocks);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
            data.length, (index) => CategoricalTransactionTable(data[index]))
      ],
    );
  }
}
