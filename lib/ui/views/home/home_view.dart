import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/ui/views/home/home_view_model.dart';
import 'package:provider_start/ui/widgets/loading_animation.dart';
import 'package:provider_start/ui/widgets/post_tile/post_tile.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel()..init(),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local.homeViewTitle),
          ios: (_) => CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
          ),
        ),
        body: model.state.match(
          loading: () => _LoadingAnimation(),
          error: (String e) => _ErrorLoadingPosts(
            message: e,
          ),
          loaded: (List<Post> posts) => _Posts(
            posts: posts,
          ),
          noPosts: () => _NoPosts(),
        ),
      ),
    );
  }
}

class _Posts extends StatelessWidget {
  final List<Post> posts;

  const _Posts({Key key, @required this.posts})
      : assert(posts != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => PostTile(
        key: Key('${posts[index].id}'),
        post: posts[index],
      ),
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

class _NoPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Center(
      child: Text(local.homeViewNoPosts),
    );
  }
}

class _ErrorLoadingPosts extends StatelessWidget {
  final String message;

  const _ErrorLoadingPosts({
    Key key,
    @required this.message,
  })  : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
