import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/core/data/strings.dart';
import 'package:tracal/data/database/database.dart';
import 'package:tracal/home/stock_bloc/stock_bloc.dart';

void useAddStockDialog(BuildContext context) async {
  String stockNameFieldText = '';
  String stockAbbrFieldText = '';
  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text('Add Stock'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: Strings.stockName),
                  onChanged: (value) => stockNameFieldText = value,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: Strings.stockAbbr),
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
                      context
                          .read<StockBloc>()
                          .add(StockError("Stock name and abbr can't be null"));
                    }
                    context.read<StockBloc>().add(
                          StockAddPressed(
                            Stock(
                                id: 0,
                                name: stockNameFieldText,
                                abbr: stockAbbrFieldText),
                          ),
                        );
                  },
                  child: const Text(Strings.add)),
            ],
          ));
}
