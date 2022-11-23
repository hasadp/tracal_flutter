import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracal/data/database/database.dart';

import './stock_state.dart';
import '../home_repository.dart';

part 'stock_event.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final HomeRepository repo;

  StockBloc({required this.repo}) : super(InitialStockState()) {
    on<StockAddPressed>(_onStockAddPressed);
    on<StockDropdownChanged>(_onStockDropdownChanged);
    on<StockStartDateChanged>((event, emit) {});
    on<StockEndDateChanged>((event, emit) {});
    on<StockDateRangeChanged>(_onStockDateRangeChanged);
    on<StockSearchPressed>(_onSearchPressed);
    on<StockErrorThrown>(_onStockErrorThrown);
    on<StockLoadStocks>(_onStockLoadStocks);
    on<StockError>(_onStockError);
    on<StockLoadTransactions>(_onStockLoadTransactions);
    on<StockShowCategorized>(_onShowCategorized);
  }

  _onStockLoadTransactions(event, emit) async {
    try {
      List<Transaction> transactions = await repo.getTransactionsBetweenDates(
          state.dateTimeRange!.start, state.dateTimeRange!.end);
      emit(state.copyWith(transactions: transactions));
    } catch (e) {
      add(StockError(e.toString()));
    }
  }

  _onStockError(event, emit) {
    emit(state.copyWith(error: event.error));
  }

  _onStockAddPressed(event, emit) async {
    try {
      await repo.addStock(event.stock);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  _onStockLoadStocks(event, emit) async {
    final stocks = await repo.getStocks();
    if (stocks.isNotEmpty) {
      emit(state.copyWith(
          stocks: stocks, dropdownValue: state.dropdownValue ?? stocks[0]));
    }
  }

  _onStockDateRangeChanged(StockDateRangeChanged event, emit) async {
    emit(state.copyWith(dateTimeRange: event.range));
  }

  _onSearchPressed(event, emit) async {}

  _onStockErrorThrown(event, emit) {
    emit(state.copyWith(error: null));
  }

  _onStockDropdownChanged(event, emit) {
    emit(state.copyWith(dropdownValue: event.value));
  }

  _onShowCategorized(event, emit) {
    emit(state.copyWith(showCategorized: event.isCategorized));
  }
}
