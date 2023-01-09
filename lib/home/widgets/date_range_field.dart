// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:tracal/core/data/strings.dart';

class DateRangeField extends StatefulWidget {
  final void Function(DateTimeRange value) onChanged;
  const DateRangeField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DateRangeField> createState() => _DateRangeFieldState();
}

class _DateRangeFieldState extends State<DateRangeField> {
  TextEditingController tec = TextEditingController();

  void _onPressed() async {
    DateTimeRange? range = await showDateRangePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year + 1));
    if (range != null) {
      widget.onChanged(range);
      final startDate = formatDate(range.start, [mm, '/', dd, '/', yyyy]);
      final endDate = formatDate(range.end, [mm, '/', dd, '/', yyyy]);
      final dateString = '$startDate - $endDate';
      setState(() {
        tec.text = dateString;
      });
    }
  }

  String? _validator(String? value) {
    if (value == '') {
      return 'Please Select Range';
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    tec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: _onPressed,
      validator: _validator,
      controller: tec,
      readOnly: true,
      decoration: InputDecoration(
        labelText: Strings.dateRange,
        icon: IconButton(
            icon: const Icon(Icons.date_range_outlined), onPressed: _onPressed),
      ),
    );
  }
}
