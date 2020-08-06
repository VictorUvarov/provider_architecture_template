import 'package:auto_route/auto_route_annotations.dart';
import 'package:provider_start/ui/views/login/login_view.dart';
import 'package:provider_start/ui/views/main/main_view.dart';
import 'package:provider_start/ui/views/startup/start_up_view.dart';
import 'package:provider_start/ui/widgets/stateful/post_details/post_details_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: MainView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: StartUpView, initial: true),
  MaterialRoute(page: PostDetailsView)
])
class $Router {}
