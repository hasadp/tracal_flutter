import 'package:flutter/material.dart';
import 'package:tracal/data/models/categorical_data.dart';
import 'package:tracal/home/widgets/categorical_transactions_table.dart';
import 'package:tracal/home/widgets/dashboard_charts.dart';

class CategoricalWindows extends StatelessWidget {
  final List<CategoricalData> categoricalDataList;
  const CategoricalWindows({super.key, required this.categoricalDataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 80),
        DashboardCharts(dataList: categoricalDataList),
        const SizedBox(height: 20),
        ...List.generate(
          categoricalDataList.length,
          (index) => CategoricalTransactionTable(categoricalDataList[index]),
        ),
      ],
    );
  }
}
