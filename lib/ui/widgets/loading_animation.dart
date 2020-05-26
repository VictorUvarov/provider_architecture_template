import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'package:provider_start/core/constant/animations.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: FlareActor(
        Animations.loader,
        animation: Animations.loader_name,
      ),
    );
  }
}
