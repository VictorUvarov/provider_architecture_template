import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/ui_models/views/home_model.dart';
import 'package:provider_start/ui/views/base_view.dart';
import 'package:provider_start/ui/widgets/post_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final local = AppLocalizations.of(context);

    return BaseView<HomeModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        if (model.state == ViewState.Busy)
          return Center(
            child: PlatformCircularProgressIndicator(),
          );

        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(local.homeViewTitle),
          ),
          body: ListView.builder(
            itemCount: model.posts.length,
            itemBuilder: (context, index) => PostTile(
              key: Key('${model.posts[index].id}'),
              post: model.posts[index],
            ),
          ),
        );
      }
    );
  }

  @override
  bool get wantKeepAlive => true;
}
