import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/ui_models/views/home_model.dart';
import 'package:provider_start/ui/views/base_view.dart';
import 'package:provider_start/ui/widgets/post_tile.dart';

part 'home_view.g.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return BaseView<HomeModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local.homeViewTitle),
          ios: (_) => CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
          ),
        ),
        body: _Posts(model),
      ),
    );
  }
}

@widget
Widget _noPosts() {
  return Center(
    child: Text('No Posts Found'),
  );
}

@widget
Widget _loadingAnimation() {
  return Center(
    child: PlatformCircularProgressIndicator(),
  );
}

@widget
Widget _posts(HomeModel model) {
  if (model.state == ViewState.Busy) {
    return const _LoadingAnimation();
  }

  if (model.posts.isEmpty) {
    return _NoPosts();
  }

  return ListView.builder(
    itemCount: model.posts.length,
    itemBuilder: (context, index) => PostTile(
      key: Key('${model.posts[index].id}'),
      post: model.posts[index],
    ),
  );
}
