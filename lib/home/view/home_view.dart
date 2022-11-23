import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/core/enums/enums.dart';
import 'package:tracal/home/home_repository.dart';
import 'package:tracal/home/transaction_cubit/transaction_cubit.dart';

import '../../core/data/data.dart';
import '../../data/database/database.dart';
import '../stock_bloc/stock_bloc.dart';
import '../stock_bloc/stock_state.dart';
import '../widgets/categorical_table._window.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Sidebar(),
                  //CategoricalWindows(
                  //   transactions: state.transactions, stocks: state.stocks)
                  //Expanded(child: TransactionsGrid(state.transactions, state.stocks))

                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        state.showCategorized
                            ? CategoricalWindows(
                                transactions: state.transactions,
                                stocks: state.stocks)
                            : TransactionsTable(
                                state.transactions, state.stocks)
                      ],
                    ),
                  ))
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
    final bloc = context.read<StockBloc>();
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
              child: Form(
                key: state.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          _showAddTradeDialog(context, bloc);
                        },
                        child: const Text(Strings.addTrade)),
                    const Divider(),
                    OutlinedButton(
                        onPressed: () => _onAddStockPressed(context),
                        child: const Text(Strings.addStock)),
                    const Divider(height: 40, thickness: 3),
                    CheckboxListTile(
                        title: const Text('Stock Wise Display'),
                        value: state.showCategorized,
                        onChanged: (value) =>
                            bloc.add(StockShowCategorized(value!))),
                    if (state.stocks.isNotEmpty)
                      DropdownButton(
                          value: state.dropdownValue,
                          items: state.stocks
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.name)))
                              .toList(),
                          onChanged: (value) => context
                              .read<StockBloc>()
                              .add(StockDropdownChanged(value!))),
                    const DateRangeField(),
                    ElevatedButton(
                        onPressed: () {
                          if (state.formKey.currentState!.validate()) {
                            bloc.add(StockLoadTransactions());
                          }
                        },
                        child: const Text(Strings.search)),
                    const Spacer(),
                  ],
                ),
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

  _showAddTradeDialog(BuildContext context, StockBloc bloc) async {
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
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (state.dropdownValue != null)
                                DropdownButtonFormField(
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
                                  const Spacer()
                                ],
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: Strings.quantity),
                                keyboardType: TextInputType.number,
                                onChanged: (value) =>
                                    cubit.onQuantityChanged(value),
                                validator: FormValidators.validateInt,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: Strings.price),
                                keyboardType: TextInputType.number,
                                onChanged: (value) =>
                                    cubit.onPriceChanged(value),
                                validator: FormValidators.validateDouble,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: Strings.brokerage),
                                keyboardType: TextInputType.number,
                                onChanged: (value) =>
                                    cubit.onBrokerageChanged(value),
                                validator: FormValidators.validateDouble,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: Strings.cvt),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => cubit.onCVTChanged(value),
                                validator: FormValidators.validateDouble,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: Strings.wht),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => cubit.onWHTChanged(value),
                                validator: FormValidators.validateDouble,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: Strings.fed),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => cubit.onFEDChanged(value),
                                validator: FormValidators.validateDouble,
                              ),
                              const DateField()
                            ],
                          ),
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
                              if (state.formKey.currentState!.validate()) {
                                cubit.addTransaction();
                                Navigator.pop(context);
                                if (bloc.state.dateTimeRange != null) {
                                  bloc.add(StockLoadTransactions());
                                }
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

class FormValidators {
  static String? validateDouble(String? value) {
    if (double.tryParse(value!) == null) {
      return 'Invalid value';
    } else {
      return null;
    }
  }

  FormValidators._();
  static String? validateInt(String? value) {
    if (int.tryParse(value!) == null) {
      return 'Invalid value';
    } else {
      return null;
    }
  }

  String? validateNoNull(String? value) {
    if (value == null) {
      return 'Invalid';
    } else {
      return null;
    }
  }
}
