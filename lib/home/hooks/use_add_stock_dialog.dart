import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/core/data/strings.dart';
import 'package:tracal/data/database/database.dart';
import 'package:tracal/home/stock_bloc/stock_bloc.dart';

Future<void> useAddStockDialog(BuildContext context) async {
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
            child: const Text(Strings.cancel)),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (stockAbbrFieldText == '' && stockNameFieldText == '') {
                context.read<StockBloc>().add(
                      StockError(Strings.addStockError),
                    );
              } else {
                context.read<StockBloc>().add(
                      StockAddPressed(
                        Stock(
                            id: 0,
                            name: stockNameFieldText.trim(),
                            abbr: stockAbbrFieldText.toUpperCase().trim()),
                      ),
                    );
              }
            },
            child: const Text(Strings.add)),
      ],
    ),
  );
}
