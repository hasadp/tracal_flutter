import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/home/home_repository.dart';
import 'package:tracal/home/hooks/use_error_dialog.dart';
import 'package:tracal/home/stock_bloc/stock_bloc.dart';
import 'package:tracal/home/stock_bloc/stock_state.dart';
import 'package:tracal/home/widgets/categorical_table_window.dart';
import 'package:tracal/home/widgets/top_bar.dart';


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
                useErrorDialog(state.error!, context);

                context.read<StockBloc>().add(StockErrorThrown());
              }
            },
            child: const HomeView()));
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: CategoricalWindows(
                  transactions: state.transactions, stocks: state.stocks),
            ),
            const TopBar(),
          ],
        ),
      ),
    );
  }
}
