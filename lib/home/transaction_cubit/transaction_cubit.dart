import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/enums/enums.dart';
import '../../data/database/database.dart';
import '../home_repository.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final HomeRepository repo = HomeRepository();

  TransactionCubit()
      : super(
          TransactionState(
              price: '',
              formKey: GlobalKey<FormState>(),
              stocks: [],
              error: '',
              transactionEnum: TransactionEnum.buy,
              qty: '',
              brokerage: '',
              fed: '',
              cvt: '',
              wht: ''),
        );

  Future<void> loadStocks() async {
    try {
      final stocks = await repo.getStocks();
      if (stocks.isNotEmpty) {
        emit(state.copyWith(
            stocks: stocks, dropdownValue: state.dropdownValue ?? stocks[0]));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void onTransactionTypeChanged(TransactionEnum? value) {
    emit(state.copyWith(transactionEnum: value));
  }

  void dropdownItemChanged(Stock stock) {
    emit(state.copyWith(dropdownValue: stock));
  }

  Future<void> addTransaction() async {
    try {
      final quantity = int.parse(state.qty.trim());
      double price = double.parse(state.price.trim());
      final brokerage = double.parse(state.brokerage.trim());
      final wht = double.parse(state.wht.trim());
      final cvt = double.parse(state.cvt.trim());
      final fed = double.parse(state.fed.trim());
      double net = 0;
      if (state.transactionEnum == TransactionEnum.sell) {
        net = (-price * quantity) + brokerage + wht + cvt + fed;
      } else {
        net = (price * quantity) + brokerage + wht + cvt + fed;
      }

      final transaction = Transaction(
          id: 0,
          stockId: state.dropdownValue!.id,
          date: state.time!,
          type: state.transactionEnum!.type,
          quantity: quantity,
          price: price,
          brokerage: brokerage,
          wht: wht,
          cvt: cvt,
          net: net,
          fed: fed);
      await repo.addTransaction(transaction);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void dismissError() {
    emit(state.copyWith(error: ''));
  }

  void onWHTChanged(String value) {
    emit(state.copyWith(wht: value));
  }

  void onPriceChanged(String price) {
    emit(state.copyWith(price: price));
  }

  void onQuantityChanged(String qty) {
    emit(state.copyWith(qty: qty));
  }

  void onBrokerageChanged(String value) {
    emit(state.copyWith(brokerage: value));
  }

  void onDateChanged(DateTime date) {
    emit(state.copyWith(time: date));
  }

  String? validateDate(String? value) {
    if (state.time == null) {
      return 'Select Date';
    } else {
      return null;
    }
  }

  onCVTChanged(String value) {
    emit(state.copyWith(cvt: value));
  }

  onFEDChanged(String value) {
    emit(state.copyWith(fed: value));
  }
}
