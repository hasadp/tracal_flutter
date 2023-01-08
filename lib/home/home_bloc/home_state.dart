// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSearchInProgress extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSearchFailed extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSearchSuccess extends HomeState {
  final List<CategoricalData> categoricalDataList;
  HomeSearchSuccess({
    required this.categoricalDataList,
  });
  @override
  List<Object?> get props => [categoricalDataList];
}

class HomeError extends HomeState {
  @override
  List<Object?> get props => [];
}
