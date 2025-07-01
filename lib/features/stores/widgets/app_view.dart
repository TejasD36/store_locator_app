import '../../../core.dart';
import 'app_error.dart';
import 'app_loading.dart';
import 'app_no_data.dart';

class AppView extends StatefulWidget {
  final Status status;
  final AppException? exception;
  final Widget child;
  final VoidCallback? onRefresh;
  const AppView({super.key, required this.status, this.exception, required this.child, this.onRefresh});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    switch (widget.status) {
      case Status.loading:
        return AppLoadingWidget();

      case Status.error:
        return AppErrorWidget(exception: widget.exception!, onRefresh: widget.onRefresh);

      case Status.completed:
        return widget.child;
      default:
        return AppNoDataWidget();
    }
  }
}
