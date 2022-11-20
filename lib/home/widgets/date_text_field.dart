import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/data/strings.dart';
import '../stock_bloc/stock_bloc.dart';

class DateRangeField extends StatefulWidget {
  const DateRangeField({Key? key}) : super(key: key);

  @override
  State<DateRangeField> createState() => _DateRangeFieldState();
}

class _DateRangeFieldState extends State<DateRangeField> {
  TextEditingController tec = TextEditingController();

  @override
  void dispose() {
    tec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == '') {
          return 'Please Select Range';
        } else {
          return null;
        }
      },
      controller: tec,
      readOnly: true,
      decoration: InputDecoration(
          labelText: Strings.dateRange,
          icon: IconButton(
            icon: const Icon(Icons.date_range_outlined),
            onPressed: ([bool mounted = true]) async {
              DateTimeRange? range = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(DateTime.now().year + 1));
              if (range != null) {
                if (!mounted) return;
                context.read<StockBloc>().add(StockDateRangeChanged(range));
                final startDate =
                    formatDate(range.start, [mm, '/', dd, '/', yyyy]);
                final endDate = formatDate(range.end, [mm, '/', dd, '/', yyyy]);
                final dateString = '$startDate - $endDate';
                setState(() {
                  tec.text = dateString;
                });
              }
            },
          )),
    );
  }
}