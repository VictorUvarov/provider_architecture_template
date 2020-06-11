import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/ui/widgets/stateful/post_tile/post_tile_view_model.dart';
import 'package:stacked/stacked.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({Key key, @required this.post})
      : assert(post != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostTileViewModel>.nonReactive(
      viewModelBuilder: () => PostTileViewModel(),
      onModelReady: (model) => model.init(post),
      builder: (context, model, child) => PlatformWidget(
        android: (_) => Card(
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
        ios: (_) => Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.grey,
              ),
            ],
          ),
          child: CupertinoButton(
            onPressed: model.showPostDetails,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.post.title),
                Text(
                  model.post.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
