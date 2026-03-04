import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home/view/home_view.dart';

Future<void> main() async {
  runZonedGuarded(
      () => runApp(const ProviderScope(
            child: MaterialApp(
              home: HomePage(),
            ),
          )),
      (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}
