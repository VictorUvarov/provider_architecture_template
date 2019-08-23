import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:provider_start/core/constant/animations.dart';
import 'package:provider_start/core/enums/tab_view.dart';
import 'package:provider_start/core/services/api_service.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/ui/views/tab_container.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _api = locator<ApiService>();
    final theme = Theme.of(context);

    return SplashScreen.navigate(
      backgroundColor: theme.primaryColor,
      width: 100.0,
      name: Animations.Loader,
      next: TabContainer(view: TabView.Home),
      until: () async {
        await _api.init();
      },
      loopAnimation: Animations.StartName,
    );
  }
}
