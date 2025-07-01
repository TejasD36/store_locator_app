import '../../../core.dart';

class AppLoadingWidget extends StatelessWidget {
  final bool isInitialApi;
  const AppLoadingWidget({super.key, this.isInitialApi = true});

  @override
  Widget build(BuildContext context) {
    return isInitialApi
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            // color: effectiveTextColor,
            color: Colors.orange,
          ),
        );
  }
}
