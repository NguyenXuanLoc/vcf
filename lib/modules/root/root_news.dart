import 'package:base_bloc/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../../router/application.dart';

class RootNews extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const RootNews({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  State<RootNews> createState() => _RootNewsState();
}

class _RootNewsState extends State<RootNews> {
  @override
  void initState() {
    final router = FluroRouter();
    NewsRouter.configureMainRoutes(router);
    Application.routerNews = router;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: Application.routerNews.generator,
    );
  }
}
