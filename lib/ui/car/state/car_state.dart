import 'package:send_me/_lib.dart';
import 'package:send_me/core/model/car_data_model.dart';

class CarState {
  final LoadingState viewState;
  final List<Cars>? cars;
  final int pageSize;
  final bool? fetchMore;
  final bool? gettingMore;
  const CarState._(
      {required this.viewState,
      this.cars,
      required this.pageSize,
      this.gettingMore,
      this.fetchMore});

  factory CarState.initial() => const CarState._(
      viewState: LoadingState.idle,
      pageSize: 1,
      cars: [],
      fetchMore: true,
      gettingMore: false);

  CarState copyWith(
      {List<Cars>? cars,
      LoadingState? viewState,
      int? pageSize,
      bool? gettingMore,
      bool? fetchMore}) {
    return CarState._(
        cars: [...this.cars!, ...cars!],
        fetchMore: fetchMore ?? this.fetchMore,
        gettingMore: gettingMore ?? this.gettingMore,
        viewState: viewState ?? this.viewState,
        pageSize: pageSize ?? this.pageSize);
  }
}
