import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/ui_models/views/home_model.dart';
import 'package:provider_start/ui/views/base_view.dart';
import 'package:provider_start/ui/widgets/post_tile.dart';

part 'home_view.g.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final local = AppLocalizations.of(context);

    return BaseView<HomeModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local.homeViewTitle),
        ),
        body: _Posts(model),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

@widget
Widget _loadingAnimation() {
  return Center(
    child: PlatformCircularProgressIndicator(),
  );
}

@widget
Widget _posts(HomeModel model) {
  if (model.state == ViewState.Busy) {
    return const _LoadingAnimation();
  }

  return ListView.builder(
    itemCount: model.posts.length,
    itemBuilder: (context, index) => PostTile(
      key: Key('${model.posts[index].id}'),
      post: model.posts[index],
    ),
  );
}
