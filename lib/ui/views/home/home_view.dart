import 'package:flutter/material.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/ui_models/views/home_model.dart';
import 'package:provider_start/ui/views/base_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).homeViewTitle),
        ),
      ),
    );
  }
}
