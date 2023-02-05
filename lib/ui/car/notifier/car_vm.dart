import 'package:send_me/core/model/car_data_model.dart';
import 'package:send_me/core/repository/car_repo.dart';
import 'package:send_me/ui/car/state/car_state.dart';
import '../../../_lib.dart';

class CarVm extends StateNotifier<CarState> {
  CarVm(this._read) : super(CarState.initial()) {
    getCars();
  }
  final Ref _read;
  final CarRepo _carRepo = locator<CarRepo>();

  getCars() async {
    try {
      state = state.copyWith(
        viewState: LoadingState.loading,
      );
      final result = await _carRepo.getCars(state.pageSize);

      if (result.status!) {
        appPrint(state.viewState.name);
        CarsData data = result.data;
        int newPageSize = state.pageSize + 1;
        state = state.copyWith(
            viewState: LoadingState.idle,
            cars: data.cars ?? [],
            fetchMore: data.cars!.isNotEmpty,
            pageSize: newPageSize);
      } else {
        state = state.copyWith(
          viewState: LoadingState.error,
        );
      }
    } catch (e) {
      state = state.copyWith(
        viewState: LoadingState.error,
      );
    }
  }

  getMoreCars() async {
    try {
      state = state.copyWith(gettingMore: true);
      final result = await _carRepo.getCars(state.pageSize);

      if (result.status!) {
        appPrint(state.viewState.name);
        CarsData data = result.data;
        int newPageSize = state.pageSize + 1;
        if (data.cars!.isNotEmpty) {
          state = state.copyWith(
              viewState: LoadingState.idle,
              gettingMore: false,
              cars: data.cars ?? [],
              fetchMore: data.cars!.isNotEmpty,
              pageSize: newPageSize);
        } else {
          state = state.copyWith(gettingMore: false);
          showErrorToast('No more cars in record');
        }
      } else {
        state = state.copyWith(gettingMore: false);
        showErrorToast(result.message!);
      }
    } catch (e) {
      state = state.copyWith(gettingMore: false);
      showErrorToast('error fetching cars');
    }
  }
}

final selectedCarIndex = StateProvider.autoDispose((ref) => -1);

final carVm = StateNotifierProvider.autoDispose<CarVm, CarState>(
  (ref) => CarVm(ref),
);
