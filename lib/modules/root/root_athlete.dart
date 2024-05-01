import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../../router/application.dart';

class RootAthlete extends StatefulWidget {
  const RootAthlete({Key? key}) : super(key: key);

  @override
  State<RootAthlete> createState() => _RootAthleteState();
}

class _RootAthleteState extends State<RootAthlete> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: 'RootCategoryPageNavigatorState');

  @override
  void initState() {
    final router = FluroRouter();
    AthleteRouter.configureMainRoutes(router);
    Application.routerAthlete = router;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          onGenerateRoute: Application.routerAthlete.generator,
        ),
        onWillPop: () async {
          return !navigatorKey.currentState!.canPop();
        });
  }
}
