import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/home/providers/home_provider.dart';
import 'package:tracal/home/widgets/single_transaction_table.dart';

class TransactionsView extends ConsumerWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeFilter = ref.watch(transactionTypeProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              // Buy/Sell Segmented Button
              SegmentedButton<String?>(
                segments: const [
                  ButtonSegment(value: null, label: Text('All')),
                  ButtonSegment(value: 'B', label: Text('Buy')),
                  ButtonSegment(value: 'S', label: Text('Sell')),
                ],
                selected: {typeFilter},
                onSelectionChanged: (Set<String?> newSelection) {
                  ref
                      .read(transactionTypeProvider.notifier)
                      .update(newSelection.first);
                  ref
                      .read(transactionsPageProvider.notifier)
                      .update(0); // reset page
                },
              ),
              const SizedBox(width: 20),
              // Multi-select for Stocks could be a simple Dropdown or a bottom sheet
              // Here we implement a simple PopupMenuButton for multi-select
              const StockMultiSelectDropdown(),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
                onPressed: () {
                  ref.invalidate(paginatedTransactionsProvider);
                  ref.invalidate(transactionsCountProvider);
                  ref.invalidate(categoricalDataProvider);
                },
              ),
            ],
          ),
        ),
        Expanded(child: SingleTransactionTable()),
      ],
    );
  }
}

class StockMultiSelectDropdown extends ConsumerWidget {
  const StockMultiSelectDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocksAsync = ref.watch(stocksProvider);
    final selectedStocks = ref.watch(selectedStocksProvider);

    return stocksAsync.when(
      data: (stocks) {
        if (stocks.isEmpty) return const SizedBox.shrink();

        return PopupMenuButton<int>(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedStocks.isEmpty
                      ? 'Filter by Stocks (All)'
                      : '${selectedStocks.length} Stocks Selected',
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          itemBuilder: (context) {
            return stocks.map((s) {
              final isSelected = selectedStocks.contains(s.id);
              return CheckedPopupMenuItem<int>(
                value: s.id,
                checked: isSelected,
                child: Text('${s.name} (${s.abbr})'),
              );
            }).toList();
          },
          onSelected: (val) {
            final List<int> current = List.from(selectedStocks);
            if (current.contains(val)) {
              current.remove(val);
            } else {
              current.add(val);
            }
            ref.read(selectedStocksProvider.notifier).update(current);
            ref.read(transactionsPageProvider.notifier).update(0); // reset page
          },
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (e, s) => const SizedBox.shrink(),
    );
  }
}
