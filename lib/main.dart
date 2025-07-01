import 'core.dart';
import 'features/stores/view/stores_view.dart';
import 'features/stores/view_model/stores_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => StoresViewModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Store Locator App',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: const StoresView(),
      ),
    );
  }
}
