import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/serializers/post.dart';
import 'package:provider_start/core/ui_models/views/post_details_model.dart';
import 'package:provider_start/ui/shared/ui_helper.dart';
import 'package:provider_start/ui/views/base_view.dart';

part 'post_details.g.dart';

class PostDetailsView extends StatelessWidget {
  final Post post;

  const PostDetailsView({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PostDetailsModel>(
      onModelReady: (model) => model.init(post),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(
            post.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: PlatformCircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(post.description),
                    UIHelper.verticalSpaceLarge(),
                    _UserDetails(model),
                  ],
                ),
              ),
      ),
    );
  }
}

@widget
Widget _userDetails(PostDetailsModel model) {
  if (model.state == ViewState.Error) {
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
