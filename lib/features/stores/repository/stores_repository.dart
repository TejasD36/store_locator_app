import '../../../core.dart';
import '../model/stores_location_response_model.dart';

class StoresRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<Either<AppException, StoresLocationResponseModel>> getStoresLocation() async {
    return await _apiServices.getApi(ApiUrl.storeList, {}, StoresLocationResponseModel.fromJson);
  }
}
