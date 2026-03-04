import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tracal/core/data/strings.dart';

class DateRangeField extends StatefulWidget {
  final void Function(DateTimeRange value) onChanged;
  const DateRangeField({super.key, required this.onChanged});

  @override
  State<DateRangeField> createState() => _DateRangeFieldState();
}

class _DateRangeFieldState extends State<DateRangeField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderDateRangePicker(
      name: 'date_range',
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 1),
      decoration: InputDecoration(
        labelText: Strings.dateRange,
        icon: const Icon(Icons.date_range_outlined),
      ),
      onChanged: (val) {
        if (val != null) {
          widget.onChanged(val);
        }
      },
      validator: FormBuilderValidators.required(),
    );
  }
}
