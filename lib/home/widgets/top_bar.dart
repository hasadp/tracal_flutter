import 'package:flutter/material.dart';
import 'package:tracal/core/data/strings.dart';
import 'package:tracal/home/stock_bloc/stock_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/home/widgets/date_range_field.dart';
import 'package:tracal/home/hooks/use_add_stock_dialog.dart';
import 'package:tracal/home/hooks/use_add_trade_dialog.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StockBloc>().state;
    final bloc = context.read<StockBloc>();

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(210, 210, 210, 100)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () {
                  useAddTradeDialog(context, bloc);
                },
                child: const Text(Strings.addTrade),
              ),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () => useAddStockDialog(context),
                child: const Text(Strings.addStock),
              ),
              const Spacer(),
              const SizedBox(
                width: 250,
                child: DateRangeField(),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (state.formKey.currentState!.validate()) {
                      bloc.add(StockLoadTransactions());
                    }
                  },
                  child: const Text(Strings.search)),
            ],
          ),
        ),
      ),
    );
  }
}
