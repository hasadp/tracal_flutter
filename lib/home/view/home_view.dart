import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/core/data/strings.dart';
import 'package:tracal/home/home_bloc/home_bloc.dart';
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
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(
        context.read<HomeRepository>(),
      ),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (BuildContext context, state) async {
          if (state is HomeError) {
            useErrorDialog('Error', context);
          }
        },
        child: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final state = context.watch<HomeBloc>().state;
                if (state is HomeSearchSuccess) {
                  return SingleChildScrollView(
                    child: CategoricalWindows(
                      categoricalDataList: state.categoricalDataList,
                    ),
                  );
                } else if (state is HomeError) {
                  return const Center(
                    child: Text(Strings.searchErrorHome),
                  );
                }
                return Container();
              },
            ),
            const TopBar(),
          ],
        ),
      ),
    );
  }
}
