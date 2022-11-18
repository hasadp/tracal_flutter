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
    on<StockAddPressed>((event, emit) async {
      try {
        await repo.addStock(event.stock);
      } catch (e) {
        emit(state.copyWith(error: e.toString()));
      }
    });
    on<StockStartDateChanged>((event, emit) {});
    on<StockEndDateChanged>((event, emit) {});
    on<StockSearchPressed>((event, emit) async {
      final stocks = await repo.getStocks();
      emit(state.copyWith(stocks: stocks));
    });
    on<StockErrorThrown>((event, emit) {
      emit(state.copyWith(error: null));
    });
  }
}
