import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/ui/widgets/post_tile/post_tile_view_model.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({Key key, @required this.post})
      : assert(post != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostTileViewModel>.value(
      value: PostTileViewModel()..init(post),
      builder: (context, child) {
        final model = context.watch<PostTileViewModel>();

        return PlatformWidget(
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
        );
      },
    );
  }
}
