// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeAddTradePressed extends HomeEvent {
  final BuildContext context;
  HomeAddTradePressed({
    required this.context,
  });
}

class HomeAddStockPressed extends HomeEvent {
  final BuildContext context;
  HomeAddStockPressed({
    required this.context,
  });
}

class HomeSearchPressed extends HomeEvent {}

class HomeSearchDateRangeChanged extends HomeEvent {
  final DateTimeRange dateTimeRange;

  HomeSearchDateRangeChanged({required this.dateTimeRange}) : super();
}

class HomeRefreshed extends HomeEvent {}
