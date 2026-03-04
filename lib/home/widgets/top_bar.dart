import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/core/data/strings.dart';
import 'package:tracal/home/providers/home_provider.dart';
import 'package:tracal/home/widgets/date_range_field.dart';
import 'package:tracal/home/hooks/use_add_trade_dialog.dart';
import 'package:tracal/home/hooks/use_add_stock_dialog.dart';

class TopBar extends ConsumerWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(210, 210, 210, 100)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () => useAddTradeDialog(context, ref),
                child: const Text(Strings.addTrade),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () => useAddStockDialog(context, ref),
                child: const Text(Strings.addStock),
              ),
              const Spacer(),
              SizedBox(
                width: 250,
                child: DateRangeField(
                  onChanged: (DateTimeRange dateTimeRange) {
                    ref
                        .read(dateRangeProvider.notifier)
                        .setRange(dateTimeRange);
                  },
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => ref.invalidate(categoricalDataProvider),
                child: const Text(Strings.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
