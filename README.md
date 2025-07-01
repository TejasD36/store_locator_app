# Store Locator App

A Flutter project for displaying a list of store locations on Google Maps, with search and smooth collapsing of the map view on scroll.

## 🚀 Features

- Google Maps integration with custom markers.
- Store list with distance and timings.
- Search bar to filter stores by name.
- Collapsible Google Map view when scrolling.
- MVVM architecture with Provider for state management.

## 📂 Project Structure

```
lib/
  core/
    api/
    utils/
  features/
    stores/
      model/
      repository/
      view/
      view_model/
      widgets/
  main.dart
```

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| [provider](https://pub.dev/packages/provider) | ^6.1.5 | State management |
| [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) | ^2.12.3 | Maps integration |
| [dartz](https://pub.dev/packages/dartz) | ^0.10.1 | Functional programming (Either, Option) |
| [dio](https://pub.dev/packages/dio) | ^5.8.0+1 | HTTP networking |
| [connectivity_plus](https://pub.dev/packages/connectivity_plus) | ^6.1.4 | Network connectivity checks |
| [talker_dio_logger](https://pub.dev/packages/talker_dio_logger) | ^4.9.1 | HTTP logging |
| [sliver_tools](https://pub.dev/packages/sliver_tools) | ^0.2.12 | Advanced sliver handling (for collapsible map) |

## ⚙️ Configuration

**Android:**
- `AndroidManifest.xml` includes:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY"/>
```

**Gradle:**
- Ensure multidex enabled if needed.
- Internet permission added.

## 🏗️ Collapsing Map with Slivers

The `CustomScrollView` uses `SliverAppBar` with `FlexibleSpaceBar` to show the Google Map, which collapses smoothly on scroll:

```dart
SliverAppBar(
  expandedHeight: MediaQuery.of(context).size.height * 0.4,
  pinned: false,
  floating: false,
  flexibleSpace: FlexibleSpaceBar(
    background: _buildMap(),
  ),
),
```

## 🔍 Search Functionality

A `TextField` is placed above the `CustomScrollView` in a `Column` to search store names:

```dart
TextField(
  onChanged: (query) {
    _viewModel.filterStores(query);
  },
  decoration: InputDecoration(
    hintText: "Search stores...",
  ),
),
```

Filtering logic in `ViewModel`:

```dart
void filterStores(String query) {
  if (query.isEmpty) {
    visibleStores = List.from(_allStores);
  } else {
    visibleStores = _allStores.where((store) {
      final name = store.storeLocation?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase());
    }).toList();
  }
  notifyListeners();
}
```

## 🛠️ Running

1. `flutter pub get`
2. `flutter run`

## 📝 License

This project is for assessment purposes.

---

**Repository:**  
[GitHub - store_locator_app](https://github.com/TejasD36/store_locator_app.git)
