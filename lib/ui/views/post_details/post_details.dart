import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/serializers/post.dart';
import 'package:provider_start/core/ui_models/views/post_details_model.dart';
import 'package:provider_start/ui/shared/ui_helper.dart';
import 'package:provider_start/ui/views/base_view.dart';

class PostDetailsView extends StatelessWidget {
  final Post post;

  const PostDetailsView({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PostDetailsModel>(
      onModelReady: (model) => model.init(post),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(post.title),
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
                    Text(model.user.username),
                    UIHelper.verticalSpaceMedium(),
                    Text(model.user.name),
                    UIHelper.verticalSpaceMedium(),
                    Text(model.user.website),
                  ],
                ),
              ),
      ),
    );
  }
}
