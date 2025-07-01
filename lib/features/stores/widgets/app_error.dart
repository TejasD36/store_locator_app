import '../../../core.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException exception;
  final VoidCallback? onRefresh;

  const AppErrorWidget({super.key, required this.exception, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(exception.message)));
  }
}
