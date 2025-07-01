import '../../../core.dart';

class AppNoDataWidget extends StatelessWidget {
  final String message;
  const AppNoDataWidget({super.key, this.message = "Data not found."});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(message)));
  }
}
