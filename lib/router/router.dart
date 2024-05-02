import 'package:base_bloc/router/router_handle.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routers {
  static String root = "/";
  static String test = "/test";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext? context, Map<String, List<String>>? params) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeSplash);
  }
}

class HomeRouter {
  static String root = '/';
  static String tournamentDetail = '/tournamentDetail';
  static String athleteDetail = '/athleteDetail';

  static configureMainRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (c, p) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeTabHome);
    router.define(tournamentDetail, handler: routeTournamentDetail);
    router.define(athleteDetail, handler: routeAthleteDetail);
  }
}

class AthleteRouter {
  static String root = '/';
  static String athleteDetail = '/athleteDetail';

  static configureMainRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (c, p) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeTabAthlete);
    router.define(athleteDetail, handler: routeAthleteDetail);
  }
}

class RaceRouter {
  static String root = '/';
  static String tournamentDetail = '/tournamentDetail';

  static configureMainRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (c, p) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeTabRace);
    router.define(tournamentDetail, handler: routeTournamentDetail);
  }
}

class NewsRouter {
  static String root = '/';
  static String newsDetail = '/newsDetail';

  static configureMainRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (c, p) {
      logE("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeTabNews);
    router.define(newsDetail, handler: routeNewsDetail);
  }
}
