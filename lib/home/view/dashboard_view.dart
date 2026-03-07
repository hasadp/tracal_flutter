import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/home/providers/home_provider.dart';
import 'package:tracal/home/widgets/dashboard_charts.dart';
import 'package:tracal/data/models/categorical_data.dart';
import 'package:tracal/core/data/const.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateList = ref.watch(categoricalDataProvider);

    return stateList.when(
      data: (list) {
        if (list.isEmpty) {
          return const Center(child: Text("No transactions available."));
        }
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: DashboardCharts(dataList: list),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Summary by Stock',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(Colors.grey[200]),
                    columns: const [
                      DataColumn(label: Text('Stock')),
                      DataColumn(label: Text('Buy Qty')),
                      DataColumn(label: Text('Sell Qty')),
                      DataColumn(label: Text('Invested')),
                      DataColumn(label: Text('Realized')),
                      DataColumn(label: Text('Net Return')),
                    ],
                    rows: list.map((item) {
                      return DataRow(cells: [
                        DataCell(Text('${item.stockName} (${item.stockAbbr})')),
                        DataCell(Text(item.buyQty.toString())),
                        DataCell(Text(item.sellQty.toString())),
                        DataCell(Text(item.buyAmount.toString())),
                        DataCell(Text(item.sellAmount.toString())),
                        DataCell(
                          Text(
                            (item.sellAmount - item.buyAmount).toStringAsFixed(2),
                            style: TextStyle(
                              color: (item.sellAmount - item.buyAmount) >= 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 50)),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text('Error loading dashboard')),
    );
  }
}
