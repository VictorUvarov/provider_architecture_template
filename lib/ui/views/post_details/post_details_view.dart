import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/models/user/user.dart';
import 'package:provider_start/ui/shared/ui_helper.dart';
import 'package:provider_start/ui/views/post_details/post_details_view_model.dart';
import 'package:provider_start/ui/widgets/loading_animation.dart';
import 'package:stacked/stacked.dart';

class PostDetailsView extends StatelessWidget {
  final Post post;

  const PostDetailsView({Key key, @required this.post})
      : assert(post != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostDetailsViewModel>.reactive(
      viewModelBuilder: () => PostDetailsViewModel()..init(post),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(
            post.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformWidget(
              android: (_) => Text(post.description),
              ios: (_) => Text(
                post.description,
                style: CupertinoTheme.of(context).textTheme.textStyle,
              ),
            ),
            UIHelper.verticalSpaceLarge(),
            model.state.match(
              loading: () => _LoadingAnimation(),
              loaded: (user) => _UserDetails(
                user: user,
              ),
              error: (message) => _ErrorIcon(),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserDetails extends StatelessWidget {
  final User user;

  const _UserDetails({
    Key key,
    @required this.user,
  })  : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      android: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(user.username),
          UIHelper.verticalSpaceMedium(),
          Text(user.name),
          UIHelper.verticalSpaceMedium(),
          Text(user.website),
        ],
      ),
      ios: (_) {
        final style = CupertinoTheme.of(context).textTheme.textStyle;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              user.username,
              style: style,
            ),
            UIHelper.verticalSpaceMedium(),
            Text(
              user.name,
              style: style,
            ),
            UIHelper.verticalSpaceMedium(),
            Text(
              user.website,
              style: style,
            ),
          ],
        );
      },
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

class _ErrorIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.error_outline);
  }
}
