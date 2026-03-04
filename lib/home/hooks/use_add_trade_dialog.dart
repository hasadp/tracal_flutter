import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:tracal/core/data/strings.dart';
import 'package:tracal/core/enums/enums.dart';
import 'package:tracal/data/database/database.dart';
import 'package:tracal/home/providers/transaction_form_provider.dart';

Future<void> useAddTradeDialog(BuildContext context, WidgetRef parentRef) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return const AddTradeDialog();
      });
}

class AddTradeDialog extends ConsumerStatefulWidget {
  const AddTradeDialog({super.key});

  @override
  ConsumerState<AddTradeDialog> createState() => _AddTradeDialogState();
}

class _AddTradeDialogState extends ConsumerState<AddTradeDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transactionFormProvider);
    final notifier = ref.read(transactionFormProvider.notifier);

    return AlertDialog(
      title: const Text(Strings.addTrade),
      content: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.stocks.isNotEmpty)
                FormBuilderDropdown<Stock>(
                    name: 'stock',
                    decoration: const InputDecoration(labelText: 'Stock'),
                    initialValue: state.dropdownValue,
                    items: state.stocks
                        .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) notifier.dropdownItemChanged(value);
                    }),
              FormBuilderRadioGroup<TransactionEnum>(
                name: 'type',
                initialValue: state.transactionEnum,
                decoration: const InputDecoration(border: InputBorder.none),
                options: const [
                  FormBuilderFieldOption(value: TransactionEnum.buy, child: Text(Strings.buy)),
                  FormBuilderFieldOption(value: TransactionEnum.sell, child: Text(Strings.sell)),
                ],
                onChanged: notifier.onTransactionTypeChanged,
              ),
              FormBuilderTextField(
                name: 'quantity',
                decoration: const InputDecoration(labelText: Strings.quantity),
                keyboardType: TextInputType.number,
                onChanged: (val) => notifier.onQuantityChanged(val ?? ''),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              FormBuilderTextField(
                name: 'price',
                decoration: const InputDecoration(labelText: Strings.price),
                keyboardType: TextInputType.number,
                onChanged: (val) => notifier.onPriceChanged(val ?? ''),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              FormBuilderTextField(
                name: 'brokerage',
                decoration: const InputDecoration(labelText: Strings.brokerage),
                keyboardType: TextInputType.number,
                onChanged: (val) => notifier.onBrokerageChanged(val ?? ''),
                validator: FormBuilderValidators.numeric(),
              ),
              FormBuilderTextField(
                name: 'cvt',
                decoration: const InputDecoration(labelText: Strings.cvt),
                keyboardType: TextInputType.number,
                onChanged: (val) => notifier.onCVTChanged(val ?? ''),
                validator: FormBuilderValidators.numeric(),
              ),
              FormBuilderTextField(
                name: 'wht',
                decoration: const InputDecoration(labelText: Strings.wht),
                keyboardType: TextInputType.number,
                onChanged: (val) => notifier.onWHTChanged(val ?? ''),
                validator: FormBuilderValidators.numeric(),
              ),
              FormBuilderTextField(
                name: 'fed',
                decoration: const InputDecoration(labelText: Strings.fed),
                keyboardType: TextInputType.number,
                onChanged: (val) => notifier.onFEDChanged(val ?? ''),
                validator: FormBuilderValidators.numeric(),
              ),
              FormBuilderDateTimePicker(
                name: 'date',
                inputType: InputType.date,
                format: DateFormat('MM/dd/yyyy'),
                initialDate: DateTime.now(),
                initialValue: DateTime.now(),
                decoration: const InputDecoration(
                  labelText: Strings.date,
                  hintText: Strings.clickToSelect,
                  suffixIcon: Icon(Icons.date_range_outlined),
                ),
                onChanged: (val) {
                  if (val != null) {
                    notifier.onDateChanged(val);
                  }
                },
                validator: FormBuilderValidators.required(),
              ),
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
                          content: const Text('Please add stock first'),
                        ));
                return;
              }
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                await notifier.addTransaction();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: const Text(Strings.add))
      ],
    );
  }
}

