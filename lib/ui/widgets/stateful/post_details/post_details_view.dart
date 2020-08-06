import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/ui/shared/ui_helper.dart';
import 'package:provider_start/ui/widgets/stateful/post_details/post_details_view_model.dart';
import 'package:provider_start/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';

class PostDetailsView extends StatelessWidget {
  final Post post;

  const PostDetailsView({Key key, @required this.post})
      : assert(post != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostDetailsViewModel>.reactive(
      viewModelBuilder: () => PostDetailsViewModel(),
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
              material: (_, __) => Text(post.description),
              cupertino: (_, __) => Text(
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

class _AdditionalInfo extends ViewModelWidget<PostDetailsViewModel> {
  @override
  Widget build(BuildContext context, PostDetailsViewModel model) {
    if (model.isBusy) {
      return _LoadingAnimation();
    }
    if (model.usererror) {
      return _ErrorIcon();
    }
    return _UserDetails();
  }
}

class _UserDetails extends ViewModelWidget<PostDetailsViewModel> {
  @override
  Widget build(BuildContext context, PostDetailsViewModel model) {
    return PlatformWidget(
      material: (_, __) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(model.user.username),
          UIHelper.verticalSpaceMedium(),
          Text(model.user.name),
          UIHelper.verticalSpaceMedium(),
          Text(model.user.website),
        ],
      ),
      cupertino: (_, __) {
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
