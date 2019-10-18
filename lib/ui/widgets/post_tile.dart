import 'package:flutter/material.dart';
import 'package:provider_start/core/serializers/post.dart';
import 'package:provider_start/ui/shared/ui_helper.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        title: Text(
          post.title,
          style: textTheme.subhead.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              post.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            UIHelper.verticalSpaceMedium(),
            Text(
              post.user.name,
              style: textTheme.caption.copyWith(
                color: Colors.grey[500],
              ),
            )
          ],
        ),
        isThreeLine: true,
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}
