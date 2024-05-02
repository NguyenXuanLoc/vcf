import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../../router/application.dart';

class RootHome extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const RootHome({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  State<RootHome> createState() => _RootHomeState();
}

class _RootHomeState extends State<RootHome> {
  @override
  void initState() {
    final router = FluroRouter();
    HomeRouter.configureMainRoutes(router);
    Application.routerHome = router;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: Application.routerHome.generator,
    );
  }
}
