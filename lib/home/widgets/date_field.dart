import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:tracal/core/data/strings.dart';

class DateField extends StatefulWidget {
  final void Function(DateTime dateTime) onChanged;
  const DateField({super.key, required this.onChanged});

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
      lastDate: DateTime(DateTime.now().year + 1),
    );
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
    return TextFormField(
      onTap: _onPressed,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a date';
        }
        return null;
      },
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
