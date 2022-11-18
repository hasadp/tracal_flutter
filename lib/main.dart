import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/home/home_repository.dart';

import 'home/view/home_view.dart';

Future<void> main() async {
  runZonedGuarded(
      () => runApp(MaterialApp(
            home: RepositoryProvider(
              create: (context) => HomeRepository(),
              child: const HomePage(),
            ),
          )),
      (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}
