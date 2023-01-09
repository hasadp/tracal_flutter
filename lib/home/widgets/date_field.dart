import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/core/data/strings.dart';
import 'package:tracal/home/transaction_cubit/transaction_cubit.dart';

class DateField extends StatefulWidget {
  final void Function(DateTime dateTime) onChanged;
  const DateField({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  TextEditingController tec = TextEditingController();

  void _onPressed() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      widget.onChanged(date);
      setState(() {
        tec.text = formatDate(date, [mm, '/', dd, '/', yyyy]);
      });
    }
  }

  @override
  void dispose() {
    tec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionCubit>();
    return TextFormField(
      onTap: _onPressed,
      validator: cubit.validateDate,
      readOnly: true,
      controller: tec,
      decoration: const InputDecoration(
        hintText: Strings.clickToSelect,
        labelText: Strings.date,
        suffixIcon: Icon(Icons.date_range_outlined),
      ),
    );
  }
}
