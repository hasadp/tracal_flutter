import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/core/enums/enums.dart';
import 'package:tracal/home/home_repository.dart';
import 'package:tracal/home/transaction_cubit/transaction_cubit.dart';

import '../../core/data/data.dart';
import '../../data/database/database.dart';
import '../stock_bloc/stock_bloc.dart';
import '../stock_bloc/stock_state.dart';
import '../widgets/transactions_table.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StockBloc>(
        create: (_) => StockBloc(repo: context.read<HomeRepository>())
          ..add(StockLoadStocks()),
        child: BlocListener<StockBloc, StockState>(
            listener: (BuildContext context, state) async {
              if (state.error != null) {
                _showErrorDialog(state.error!, context);

                context.read<StockBloc>().add(StockErrorThrown());
              }
            },
            child: const HomeView()));
  }

  _showErrorDialog(String error, BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text(Strings.error),
              content: Text(error),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(Strings.close))
              ],
            ));
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StockBloc>().state;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Sidebar(),
                  Expanded(
                      child: Center(
                          child: TransactionsTable(
                              state.transactions, state.stocks)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StockBloc>().state;
    return SizedBox(
      width: 250,
      child: Container(
          decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromRGBO(210, 210, 210, 100)),
              color: const Color.fromRGBO(230, 230, 230, 100),
              borderRadius: BorderRadius.circular(8)),
          child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        _showAddTradeDialog(context);
                      },
                      child: const Text(Strings.addTrade)),
                  const Divider(),
                  OutlinedButton(
                      onPressed: () => _onAddStockPressed(context),
                      child: const Text(Strings.addStock)),
                  const Divider(height: 40, thickness: 3),
                  CheckboxListTile(
                      title: const Text('Stock Wise Display'),
                      value: false,
                      onChanged: (value) {}),
                  if (state.stocks.isNotEmpty)
                    DropdownButton(
                        value: state.dropdownValue,
                        items: state.stocks
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)))
                            .toList(),
                        onChanged: (value) => context
                            .read<StockBloc>()
                            .add(StockDropdownChanged(value!))),
                  const DateRangeField(),
                  ElevatedButton(
                      onPressed: () => context
                          .read<StockBloc>()
                          .add(StockLoadTransactions()),
                      child: const Text(Strings.search)),
                  const Spacer(),
                ],
              ),
            ),
          )),
    );
  }

  _onAddStockPressed(BuildContext context) async {
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
                      if (stockAbbrFieldText == '' &&
                          stockNameFieldText == '') {
                        context.read<StockBloc>().add(
                            StockError("Stock name and abbr can't be null"));
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

  _showAddTradeDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return BlocProvider(
              create: (context) => TransactionCubit()..loadStocks(),
              child: BlocListener<TransactionCubit, TransactionState>(
                listener: (context, state) {},
                child: Builder(
                  builder: (context) {
                    final state = context.watch<TransactionCubit>().state;
                    final cubit = context.read<TransactionCubit>();
                    return AlertDialog(
                      title: const Text(Strings.addTrade),
                      content: Form(
                        key: state.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (state.dropdownValue != null)
                              DropdownButton(
                                  value: state.dropdownValue,
                                  items: state.stocks
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e.name)))
                                      .toList(),
                                  onChanged: (value) =>
                                      {cubit.dropdownItemChanged(value!)}),
                            Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: RadioListTile<TransactionEnum>(
                                    value: TransactionEnum.buy,
                                    groupValue: state.transactionEnum,
                                    onChanged: (value) =>
                                        cubit.onTransactionTypeChanged(value),
                                    title: const Text(Strings.buy),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: RadioListTile<TransactionEnum>(
                                    value: TransactionEnum.sell,
                                    groupValue: state.transactionEnum,
                                    onChanged: (value) =>
                                        cubit.onTransactionTypeChanged(value),
                                    title: const Text(Strings.sell),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: Strings.amount),
                              keyboardType: TextInputType.number,
                              onChanged: (value) => cubit.amountChanged(value),
                              validator: (value) {
                                if (double.tryParse(value!) != null) {
                                  return null;
                                } else {
                                  return 'Invalid double';
                                }
                              },
                            ),
                            const DateField()
                          ],
                        ),
                      ),
                      actions: [
                        OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(Strings.close)),
                        ElevatedButton(
                            onPressed: () {
                              print(state.toString());
                              if (state.formKey.currentState!.validate()) {
                                cubit.addTransaction();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(Strings.add))
                      ],
                    );
                  },
                ),
              ));
        });
  }
}
