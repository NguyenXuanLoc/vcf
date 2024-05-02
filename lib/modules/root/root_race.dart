import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../../router/application.dart';

class RootRace extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const RootRace({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  State<RootRace> createState() => _RootRaceState();
}

class _RootRaceState extends State<RootRace> {
  @override
  void initState() {
    final router = FluroRouter();
    RaceRouter.configureMainRoutes(router);
    Application.routerRace = router;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: Application.routerRace.generator,
    );
  }
}
