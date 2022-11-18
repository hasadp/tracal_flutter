import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/home/home_repository.dart';
import 'package:tracal/home/transaction_cubit/transaction_cubit.dart';

import '../../core/data/data.dart';
import '../../data/database/database.dart';
import '../stock_bloc/stock_bloc.dart';
import '../stock_bloc/stock_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StockBloc>(
            create: (_) => StockBloc(repo: context.read<HomeRepository>())),
        BlocProvider(create: (_) => TransactionCubit())
      ],
      child: MultiBlocListener(listeners: [
        BlocListener<StockBloc, StockState>(
          listener: (BuildContext context, state) async {
            print(state);
            if (state.error != null) {
              _showErrorDialog(state.error!, context);

              context.read<StockBloc>().add(StockErrorThrown());
            }
          },
        ),
        BlocListener<TransactionCubit, TransactionState>(
            listener: (BuildContext context, state) {})
      ], child: const HomeView()),
    );
  }

  _showErrorDialog(String error, BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text(Strings.databaseError),
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
                  SizedBox(
                    width: 200,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromRGBO(210, 210, 210, 100)),
                            color: const Color.fromRGBO(230, 230, 230, 100),
                            borderRadius: BorderRadius.circular(8)),
                        child: SizedBox.expand(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                    onPressed: () =>
                                        _onAddStockPressed(context),
                                    child: const Text(Strings.addStock)),
                                const Divider(),
                                ElevatedButton(
                                    onPressed: () => context
                                        .read<StockBloc>()
                                        .add(StockSearchPressed()),
                                    child: const Text(Strings.search)),
                                const Spacer(),
                              ],
                            ),
                          ),
                        )),
                  ),
                  Expanded(child: Center(child: Text(state.stocks.toString())))
                ],
              ),
            ),
          ],
        ),
      ),
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
}
