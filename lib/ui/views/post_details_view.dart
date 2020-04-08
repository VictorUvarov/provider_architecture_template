import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/view_models/post_details_view_model.dart';
import 'package:provider_start/ui/shared/ui_helper.dart';
import 'package:provider_start/ui/widgets/loading_animation.dart';
import 'package:provider_start/ui/widgets/state_responsive.dart';

class PostDetailsView extends StatelessWidget {
  final Post post;

  const PostDetailsView({Key key, @required this.post})
      : assert(post != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PostDetailsViewModel>.withConsumer(
      viewModel: PostDetailsViewModel(),
      onModelReady: (model) => model.init(post),
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
            _AdditionalInfo(),
          ],
        ),
      ),
    );
  }
}

class _AdditionalInfo extends ProviderWidget<PostDetailsViewModel> {
  @override
  Widget build(BuildContext context, PostDetailsViewModel model) {
    return StateResponsive(
      state: model.state,
      idleWidget: _UserDetails(),
      busyWidget: _LoadingAnimation(),
      errorWidget: _ErrorIcon(),
    );
  }
}

class _UserDetails extends ProviderWidget<PostDetailsViewModel> {
  @override
  Widget build(BuildContext context, PostDetailsViewModel model) {
    return PlatformWidget(
      android: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(model.user.username),
          UIHelper.verticalSpaceMedium(),
          Text(model.user.name),
          UIHelper.verticalSpaceMedium(),
          Text(model.user.website),
        ],
      ),
      ios: (_) {
        final style = CupertinoTheme.of(context).textTheme.textStyle;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              model.user.username,
              style: style,
            ),
            UIHelper.verticalSpaceMedium(),
            Text(
              model.user.name,
              style: style,
            ),
            UIHelper.verticalSpaceMedium(),
            Text(
              model.user.website,
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
