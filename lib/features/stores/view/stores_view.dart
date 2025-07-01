import '../../../core.dart';
import '../model/stores_location_response_model.dart';
import '../view_model/stores_view_model.dart';
import '../widgets/app_view.dart';

class StoresView extends StatefulWidget {
  const StoresView({super.key});

  @override
  State<StoresView> createState() => _StoresViewState();
}

class _StoresViewState extends State<StoresView> {
  late StoresViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<StoresViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.getStoresList();
    });
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = Provider.of<StoresViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Stores"), centerTitle: true, backgroundColor: Colors.orange),
      body: AppView(status: _viewModel.storesResponse.status!, exception: _viewModel.storesResponse.exception, child: _buildMainBody()),
    );
  }

  Widget _buildMainBody() {
    return Column(
      children: [
        // Top Half - Map
        Expanded(flex: 1, child: _buildMap()),

        // Bottom Half - Store List
        Expanded(flex: 1, child: _buildStoreList()),
      ],
    );
  }

  Widget _buildMap() {
    return Consumer<StoresViewModel>(
      builder: (context, vm, _) {
        final markers = <Marker>{};

        for (var store in vm.storesResponse.data?.data ?? []) {
          final lat = double.tryParse(store.latitude ?? "");
          final lng = double.tryParse(store.longitude ?? "");
          if (lat != null && lng != null) {
            markers.add(
              Marker(
                markerId: MarkerId(store.code ?? ""),
                position: LatLng(lat, lng),
                infoWindow: InfoWindow(title: store.storeLocation, snippet: store.storeAddress),
                icon:
                    vm.selectedStore?.code == store.code
                        ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)
                        : BitmapDescriptor.defaultMarker,
              ),
            );
          }
        }

        return GoogleMap(
          onMapCreated: vm.onMapCreated,
          initialCameraPosition: CameraPosition(
            target:
                vm.storesResponse.data?.data?.isNotEmpty == true
                    ? LatLng(
                      double.tryParse(vm.storesResponse.data!.data!.first.latitude ?? "0") ?? 0,
                      double.tryParse(vm.storesResponse.data!.data!.first.longitude ?? "0") ?? 0,
                    )
                    : const LatLng(0, 0),
            zoom: 12,
          ),
          markers: markers,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          myLocationButtonEnabled: false,
        );
      },
    );
  }

  Widget _buildStoreList() {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: _viewModel.storesResponse.data?.data?.length ?? 0,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final store = _viewModel.storesResponse.data!.data![index];

        return _buildStoreTile(store: store);
      },
    );
  }

  Widget _buildStoreTile({required StoresData store}) {
    return InkWell(
      onTap: () {
        _viewModel.onStoreTileTapped(store);
      },
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.orange, width: 1.5), borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.orange, width: 1.5), borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.store, color: Colors.orange, size: 32),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(store.storeLocation ?? "No name", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(store.storeAddress ?? "No address", style: const TextStyle(fontSize: 14, color: Colors.black)),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child:
                            (store.distance != null)
                                ? Text(
                                  "${store.distance!.toStringAsFixed(2)} km away",
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                )
                                : SizedBox.shrink(),
                      ),
                    ],
                  ),
                  Text(
                    "${store.dayOfWeekLabel} - ${store.startTimeLabel} - ${store.endTimeLabel}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
