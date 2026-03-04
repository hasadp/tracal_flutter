import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tracal/data/models/categorical_data.dart';

class DashboardCharts extends StatelessWidget {
  final List<CategoricalData> dataList;

  const DashboardCharts({super.key, required this.dataList});

  @override
  Widget build(BuildContext context) {
    // Only show stocks that have transactions (net value > 0 or whatever logic makes sense,
    // here we just use the positive net values or buyAmount to see portfolio distribution)

    final validData = dataList
        .where((element) => element.buyAmount > 0)
        .toList();

    if (validData.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(child: Text("No data to chart yet.")),
      );
    }

    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Portfolio Distribution (Total Invested)',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: _buildSections(validData),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildSections(List<CategoricalData> validData) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];

    return List.generate(validData.length, (index) {
      final data = validData[index];
      return PieChartSectionData(
        color: colors[index % colors.length],
        value: data.buyAmount,
        title:
            '${data.stockAbbr}\n${_getPercentage(data.buyAmount, validData)}%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      );
    });
  }

  String _getPercentage(double value, List<CategoricalData> validData) {
    final total = validData.fold<double>(
      0,
      (sum, item) => sum + item.buyAmount,
    );
    if (total == 0) return '0';
    return ((value / total) * 100).toStringAsFixed(1);
  }
}
