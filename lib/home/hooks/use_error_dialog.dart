import 'package:flutter/material.dart';
import 'package:tracal/core/data/strings.dart';


useErrorDialog(String error,BuildContext context)async{
  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(Strings.error),
        content: Text(error),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(Strings.close))
        ],
      ));
}