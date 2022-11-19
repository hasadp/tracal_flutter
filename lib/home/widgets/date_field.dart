import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/home/transaction_cubit/transaction_cubit.dart';

import '../../core/data/strings.dart';

class DateField extends StatefulWidget {
  const DateField({Key? key}) : super(key: key);

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  TextEditingController tec = TextEditingController();

  @override
  void dispose() {
    tec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionCubit>();
    return TextFormField(
      validator: cubit.validateDate,
      readOnly: true,
      controller: tec,
      decoration: InputDecoration(
          labelText: Strings.date,
          icon: IconButton(
            icon: const Icon(Icons.date_range_outlined),
            onPressed: ([bool mounted = true]) async {
              final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(DateTime.now().year + 1));
              if (date != null) {
                if (!mounted) return;
                context.read<TransactionCubit>().dateChanged(date);
                setState(() {
                  tec.text = formatDate(date, [mm, '/', dd, '/', yyyy]);
                });
              }
            },
          )),
    );
  }
}
