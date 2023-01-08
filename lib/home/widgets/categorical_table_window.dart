import 'package:flutter/material.dart';
import 'package:tracal/data/models/categorical_data.dart';
import 'package:tracal/home/widgets/categorical_transactions_table.dart';

class CategoricalWindows extends StatelessWidget {
  final List<CategoricalData> categoricalDataList;
  const CategoricalWindows({Key? key, required this.categoricalDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 100,
        ),
        ...List.generate(
          categoricalDataList.length,
          (index) => CategoricalTransactionTable(
            categoricalDataList[index],
          ),
        )
      ],
    );
  }
}
