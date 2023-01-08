import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/core/data/strings.dart';
import 'package:tracal/core/enums/enums.dart';
import 'package:tracal/core/form_validators.dart';
import 'package:tracal/home/transaction_cubit/transaction_cubit.dart';
import 'package:tracal/home/widgets/date_field.dart';

Future<void> useAddTradeDialog(BuildContext context) async {
  return await showDialog(
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
                              onChanged: (value) => cubit.onPriceChanged(value),
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
                              decoration:
                                  const InputDecoration(labelText: Strings.cvt),
                              keyboardType: TextInputType.number,
                              onChanged: (value) => cubit.onCVTChanged(value),
                              validator: FormValidators.validateDouble,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: Strings.wht),
                              keyboardType: TextInputType.number,
                              onChanged: (value) => cubit.onWHTChanged(value),
                              validator: FormValidators.validateDouble,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: Strings.fed),
                              keyboardType: TextInputType.number,
                              onChanged: (value) => cubit.onFEDChanged(value),
                              validator: FormValidators.validateDouble,
                            ),
                            DateField(
                              onChanged: (dateTime) =>
                                  cubit.onDateChanged(dateTime),
                            )
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
                          onPressed: () async {
                            if (state.dropdownValue == null) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'))
                                        ],
                                        content: const Text(
                                            'Please add stock first'),
                                      ));
                              return;
                            }
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
