import '../../../core.dart';
import '../model/stores_location_response_model.dart';
import '../repository/stores_repository.dart';

class StoresViewModel extends ChangeNotifier {
  final StoresRepository _repository = StoresRepository();
  GoogleMapController? mapController;
  StoresData? selectedStore;

  ApiResponse<StoresLocationResponseModel> storesResponse = ApiResponse.initial();

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onStoreTileTapped(StoresData store) {
    selectedStore = store;
    notifyListeners();

    final lat = double.tryParse(store.latitude ?? "");
    final lng = double.tryParse(store.longitude ?? "");
    if (lat != null && lng != null) {
      mapController?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15));
    }
  }

  Future<void> getStoresList() async {
    storesResponse = ApiResponse.setResponse(ApiResponse.loading());
    notifyListeners();

    var response = await _repository.getStoresLocation();
    response.fold(
      (l) {
        storesResponse = ApiResponse.setResponse(ApiResponse.error(l));

        notifyListeners();
      },
      (r) async {
        storesResponse = ApiResponse.setResponse(ApiResponse.completed(r));
        notifyListeners();
      },
    );
  }
}
