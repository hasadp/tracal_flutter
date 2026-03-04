import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracal/home/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});
