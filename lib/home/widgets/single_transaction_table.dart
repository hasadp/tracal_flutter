import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/core/data/const.dart';
import 'package:tracal/home/providers/home_provider.dart';

class SingleTransactionTable extends ConsumerWidget {
  SingleTransactionTable({super.key});

  final sc = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(paginatedTransactionsProvider);
    final countAsync = ref.watch(transactionsCountProvider);

    return transactionsAsync.when(
      data: (transactions) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Scrollbar(
                  trackVisibility: true,
                  thumbVisibility: true,
                  thickness: 10,
                  controller: sc,
                  child: SingleChildScrollView(
                    controller: sc,
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          Colors.grey[200],
                        ),
                        columns: const [
                          DataColumn(label: Text('Stock')),
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
                        ],
                        rows: transactions.map((t) {
                          final data = t.transaction;
                          return DataRow(
                            cells: [
                              DataCell(Text(t.stock.abbr)),
                              DataCell(
                                Text(
                                  formatDate(data.date, [
                                    mm,
                                    '-',
                                    dd,
                                    '-',
                                    yyyy,
                                  ]),
                                ),
                              ),
                              DataCell(
                                Text(
                                  data.type == 'B'
                                      ? data.quantity.toString()
                                      : '',
                                ),
                              ),
                              DataCell(
                                Text(
                                  data.type == 'S'
                                      ? data.quantity.toString()
                                      : '',
                                ),
                              ),
                              DataCell(Text(data.price.toString())),
                              DataCell(
                                Text(
                                  data.type == 'B'
                                      ? (data.quantity * data.price).toString()
                                      : '',
                                ),
                              ),
                              DataCell(
                                Text(
                                  data.type == 'S'
                                      ? (data.quantity * data.price).toString()
                                      : '',
                                ),
                              ),
                              DataCell(Text(data.brokerage.toString())),
                              DataCell(Text(data.cvt.toString())),
                              DataCell(Text(data.wht.toString())),
                              DataCell(Text(data.fed.toString())),
                              DataCell(Text(data.net.toString())),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            countAsync.when(
              data: (totalRecords) {
                final page = ref.watch(transactionsPageProvider);
                final limit = ref.watch(transactionsRowsPerPageProvider);
                final totalPages = (totalRecords / limit).ceil();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Rows per page:'),
                      const SizedBox(width: 8),
                      DropdownButton<int>(
                        value: limit,
                        items: [10, 20, 50, 100].map((e) {
                          return DropdownMenuItem<int>(
                            value: e,
                            child: Text(e.toString()),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            ref
                                .read(transactionsRowsPerPageProvider.notifier)
                                .update(val);
                            ref
                                .read(transactionsPageProvider.notifier)
                                .update(0);
                          }
                        },
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: page > 0
                            ? () => ref
                                  .read(transactionsPageProvider.notifier)
                                  .previous()
                            : null,
                      ),
                      Text('Page ${page + 1} of $totalPages'),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: page < totalPages - 1
                            ? () => ref
                                  .read(transactionsPageProvider.notifier)
                                  .next()
                            : null,
                      ),
                    ],
                  ),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (e, s) => const SizedBox.shrink(),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error loading transactions: $e')),
    );
  }
}
