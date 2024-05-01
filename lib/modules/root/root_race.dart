import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../../router/application.dart';

class RootRace extends StatefulWidget {
  const RootRace({Key? key}) : super(key: key);

  @override
  State<RootRace> createState() => _RootRaceState();
}

class _RootRaceState extends State<RootRace> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: 'RootCategoryPageNavigatorState');

  @override
  void initState() {
    final router = FluroRouter();
    RaceRouter.configureMainRoutes(router);
    Application.routerRace = router;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          onGenerateRoute: Application.routerRace.generator,
        ),
        onWillPop: () async {
          return !navigatorKey.currentState!.canPop();
        });
  }
}
