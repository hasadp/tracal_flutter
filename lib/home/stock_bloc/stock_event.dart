part of 'stock_bloc.dart';

@immutable
abstract class StockEvent extends Equatable {}

class StockSearchPressed extends StockEvent {
  @override
  List<Object> get props => [];
}

class StockAddPressed extends StockEvent {
  final Stock stock;

  StockAddPressed(this.stock);

  @override
  List<Object?> get props => [stock];
}

class StockErrorThrown extends StockEvent {
  StockErrorThrown();

  @override
  List<Object?> get props => [];
}

class StockStartDateChanged extends StockEvent {
  final DateTime date;
  StockStartDateChanged(this.date);

  @override
  List<Object> get props => [date];
}

class StockEndDateChanged extends StockEvent {
  final DateTime date;
  StockEndDateChanged(this.date);

  @override
  List<Object> get props => [date];
}

class StockOpenDialog extends StockEvent {
  final BuildContext context;
  StockOpenDialog(this.context);
  @override
  List<Object> get props => [context];
}

class StockLoadDropdown extends StockEvent {
  @override
  List<Object> get props => [];
}
