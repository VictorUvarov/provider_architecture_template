import 'package:flutter/material.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/serializers/post.dart';

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
        subtitle: Text(
          post.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: true,
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.of(context).pushNamed(
            ViewRoutes.post_details,
            arguments: post,
          );
        },
      ),
    );
  }
}
