import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/home/widgets/top_bar.dart';
import 'package:tracal/home/view/transactions_view.dart';
import 'package:tracal/home/view/dashboard_view.dart';

class NavigationIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void update(int index) => state = index;
}

final navigationIndexProvider = NotifierProvider<NavigationIndexNotifier, int>(
  NavigationIndexNotifier.new,
);

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
    final currentIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8.0), child: TopBar()),
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: const [TransactionsView(), DashboardView()],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) =>
            ref.read(navigationIndexProvider.notifier).update(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}
