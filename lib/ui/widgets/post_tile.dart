import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/view_models/widgets/post_tile_view_model.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({Key key, @required this.post})
      : assert(post != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PostTileViewModel>.withoutConsumer(
      viewModel: PostTileViewModel(),
      onModelReady: (model) => model.init(post),
      builder: (context, model, child) => Card(
        child: ListTile(
          title: Text(model.post.title),
          subtitle: Text(
            model.post.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          isThreeLine: true,
          trailing: PlatformWidget(
            android: (_) => Icon(Icons.arrow_forward),
            ios: (_) => Icon(CupertinoIcons.forward),
          ),
          onTap: model.showPostDetails,
        ),
      ),
    );
  }
}
