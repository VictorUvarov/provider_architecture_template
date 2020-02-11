import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/view_models/post_details_view_model.dart';
import 'package:provider_start/ui/shared/ui_helper.dart';
import 'package:provider_start/ui/widgets/loading_animation.dart';

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
            Text(post.description),
            UIHelper.verticalSpaceLarge(),
            _UserDetails(),
          ],
        ),
      ),
    );
  }
}

class _UserDetails extends ProviderWidget<PostDetailsViewModel> {
  @override
  Widget build(BuildContext context, PostDetailsViewModel model) {
    if (model.state == ViewState.Busy) {
      return Center(
        child: LoadingAnimation(),
      );
    } else if (model.state == ViewState.Error) {
      return Icon(Icons.error_outline);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(model.user.username),
        UIHelper.verticalSpaceMedium(),
        Text(model.user.name),
        UIHelper.verticalSpaceMedium(),
        Text(model.user.website),
      ],
    );
  }
}
