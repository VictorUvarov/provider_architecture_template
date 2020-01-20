import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/view_models/home_view_model.dart';
import 'package:provider_start/ui/widgets/loading_animation.dart';
import 'package:provider_start/ui/widgets/post_tile.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ViewModelProvider<HomeViewModel>.withoutConsumer(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local.homeViewTitle),
          ios: (_) => CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
          ),
        ),
        body: _Posts(),
      ),
    );
  }
}

class _NoPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Center(
      child: Text(local.homeViewNoPosts),
    );
  }
}

class _LoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimation(),
    );
  }
}

class _Posts extends ProviderWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    if (model.state == ViewState.Busy) {
      return _LoadingAnimation();
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
}
