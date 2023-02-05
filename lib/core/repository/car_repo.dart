import 'package:send_me/_lib.dart';
import 'package:send_me/core/model/base_response.dart';
import 'package:send_me/core/model/car_data_model.dart';
import 'package:send_me/data/network_request.dart';

abstract class CarRepo {
  Future<BaseResponse> getCars(int page);
}

class CarRepoImpl extends CarRepo {
  final NetworkProvider _networkProvider;
  CarRepoImpl(this._networkProvider);

  @override
  Future<BaseResponse> getCars(int page) async {
    try {
      final result = await _networkProvider.call(
          path: AppEndpoint.getCars(page),
          method: RequestMethod.post,
          addToken: true,
          body: {});
      if (result is ApiError) {
        appPrint('the error is ${result.errorMessage}');
        return BaseResponse(status: false, message: result.errorMessage);
      }
      var data = CarsData.fromJson(result);
      return BaseResponse(
          status: true, message: result.errorMessage, data: data);
    } catch (e) {
      return BaseResponse(status: false, message: 'an error occured');
    }
  }
}
