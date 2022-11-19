part of 'stock_bloc.dart';

@immutable
abstract class StockEvent extends Equatable {}

class StockLoadTransactions extends StockEvent {
  @override
  List<Object> get props => [];
}

class StockLoadStocks extends StockEvent {
  @override
  List<Object?> get props => [];
}

class StockError extends StockEvent {
  final String error;
  StockError(this.error);
  @override
  List<Object?> get props => [error];
}

class StockDisplayTransaction extends StockEvent {
  @override
  List<Object?> get props => [];
}

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

class StockDropdownChanged extends StockEvent {
  final Stock value;

  StockDropdownChanged(this.value);

  @override
  List<Object> get props => [value];
}

class StockDateRangeChanged extends StockEvent {
  final DateTimeRange range;

  StockDateRangeChanged(this.range);

  @override
  List<Object?> get props => [range];
}
