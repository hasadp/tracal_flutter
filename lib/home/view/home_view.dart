import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/core/data/strings.dart';
import 'package:tracal/home/providers/home_provider.dart';
import 'package:tracal/home/widgets/categorical_table_window.dart';
import 'package:tracal/home/widgets/top_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateList = ref.watch(categoricalDataProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            stateList.when(
              data: (list) => SingleChildScrollView(
                child: CategoricalWindows(categoricalDataList: list),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) =>
                  Center(child: Text(Strings.searchErrorHome)),
            ),
            const TopBar(),
          ],
        ),
      ),
    );
  }
}
