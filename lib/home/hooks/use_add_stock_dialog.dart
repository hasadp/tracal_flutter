import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/core/data/strings.dart';
import 'package:tracal/data/database/database.dart';
import 'package:tracal/home/providers/home_provider.dart';
import 'package:tracal/home/providers/home_repository_provider.dart';

Future<void> useAddStockDialog(BuildContext context, WidgetRef ref) async {
  String stockNameFieldText = '';
  String stockAbbrFieldText = '';
  return await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text(Strings.addStock),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: Strings.stockName),
            onChanged: (value) => stockNameFieldText = value,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: Strings.stockAbbr),
            onChanged: (value) => stockAbbrFieldText = value,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(Strings.cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
            if (stockAbbrFieldText == '' && stockNameFieldText == '') {
            } else {
              await ref
                  .read(homeRepositoryProvider)
                  .addStock(
                    Stock(
                      id: 0,
                      name: stockNameFieldText.trim(),
                      abbr: stockAbbrFieldText.toUpperCase().trim(),
                    ),
                  );
              ref.invalidate(categoricalDataProvider);
            }
          },
          child: const Text(Strings.add),
        ),
      ],
    ),
  );
}
