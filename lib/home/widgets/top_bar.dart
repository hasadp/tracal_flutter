import 'package:flutter/material.dart';
import 'package:tracal/core/data/strings.dart';
import 'package:tracal/home/home_bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/home/widgets/date_range_field.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();

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
                onPressed: () =>
                    bloc.add(HomeAddTradePressed(context: context)),
                child: const Text(Strings.addTrade),
              ),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () =>
                    bloc.add(HomeAddStockPressed(context: context)),
                child: const Text(Strings.addStock),
              ),
              const Spacer(),
              SizedBox(
                width: 250,
                child: DateRangeField(
                  onChanged: (DateTimeRange dateTimeRange) {
                    bloc.add(HomeSearchDateRangeChanged(
                        dateTimeRange: dateTimeRange));
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () => bloc.add(HomeSearchPressed()),
                  child: const Text(Strings.search)),
            ],
          ),
        ),
      ),
    );
  }
}
