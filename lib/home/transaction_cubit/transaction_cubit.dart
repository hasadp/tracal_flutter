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
              formKey: GlobalKey<FormState>(),
              amountString: '',
              stocks: [],
              error: '',
              transactionEnum: TransactionEnum.buy),
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

  void amountChanged(String amount) {
    emit(state.copyWith(amountString: amount));
  }

  void onTransactionTypeChanged(TransactionEnum? value) {
    emit(state.copyWith(transactionEnum: value));
  }

  void dropdownItemChanged(Stock stock) {
    emit(state.copyWith(dropdownValue: stock));
  }

  void addTransaction() async {
    try {
      final transaction = Transaction(
          id: 0,
          stockId: state.dropdownValue!.id,
          date: state.time!,
          amount: double.parse(state.amountString!),
          type: state.transactionEnum!.type);
      repo.addTransaction(transaction);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void dismissError() {
    emit(state.copyWith(error: ''));
  }

  test() {
    emit(state.copyWith(amountString: '${state.amountString!}  abc'));
  }

  void getTransactions() {
    try {
      repo.getTransactions();
    } catch (e) {}
  }

  void dateChanged(DateTime date) {
    emit(state.copyWith(time: date));
  }

  String? validateDate(String? value) {
    if (state.time == null) {
      return 'Select Date';
    } else {
      return null;
    }
  }
}
