import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracal/data/database/database.dart';
import 'package:tracal/data/models/categorical_data.dart';
import 'package:tracal/home/home_repository.dart';
import 'package:tracal/home/hooks/use_add_stock_dialog.dart';
import 'package:tracal/home/hooks/use_add_trade_dialog.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  DateTimeRange? dateTimeRange;
  HomeBloc(this._homeRepository) : super(HomeInitial()) {
    on<HomeAddStockPressed>(_onHomeAddStockPressed);
    on<HomeAddTradePressed>(_onHomeAddTradePressed);
    on<HomeSearchPressed>(_onHomeSearchPressed);
    on<HomeSearchDateRangeChanged>(_onHomeSearchDateRangeChanged);
    on<HomeRefreshed>(_onHomeRefreshed);
  }

  void _onHomeAddStockPressed(event, emit) {
    useAddStockDialog(event.context, _homeRepository);
  }

  void _onHomeAddTradePressed(event, emit) async {
    await useAddTradeDialog(event.context);
    final list = await _getCategoricalDataList(dateTimeRange);
    emit(HomeSearchSuccess(categoricalDataList: list));
  }

  void _onHomeSearchPressed(event, emit) async {
    final list = await _getCategoricalDataList(dateTimeRange);
    emit(HomeSearchSuccess(categoricalDataList: list));
  }

  void _onHomeSearchDateRangeChanged(
      HomeSearchDateRangeChanged event, Emitter<HomeState> emit) {
    dateTimeRange = event.dateTimeRange;
  }

  void _onHomeRefreshed(event, emit) async {
    final list = await _getCategoricalDataList(dateTimeRange);
    emit(HomeSearchSuccess(categoricalDataList: list));
  }

  Future<List<CategoricalData>> _getCategoricalDataList(
      DateTimeRange? dateTimeRange) async {
    late final List<Transaction> transactions;
    if (dateTimeRange != null) {
      transactions = await _homeRepository.getTransactionsBetweenDates(
          dateTimeRange.start, dateTimeRange.end);
    } else {
      transactions = await _homeRepository.getTransactions();
    }
    final stocks = await _homeRepository.getStocks();

    List<CategoricalData> list = CategoricalData.categoricalList(
        transactions: transactions, stocks: stocks);
    return list;
  }
}
