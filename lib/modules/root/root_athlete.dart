import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../../router/application.dart';

class RootAthlete extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const RootAthlete({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  State<RootAthlete> createState() => _RootAthleteState();
}

class _RootAthleteState extends State<RootAthlete> {
  @override
  void initState() {
    final router = FluroRouter();
    AthleteRouter.configureMainRoutes(router);
    Application.routerAthlete = router;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: widget.navigatorKey,
        onGenerateRoute: Application.routerAthlete.generator);
  }
}
