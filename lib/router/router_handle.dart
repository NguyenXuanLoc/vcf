import 'package:base_bloc/modules/athlete_detail/athlete_detail_page.dart';
import 'package:base_bloc/modules/home_page/home_page.dart';
import 'package:base_bloc/modules/new_detail/news_detail_page.dart';
import 'package:base_bloc/modules/race_detail/race_detail_page.dart';
import 'package:base_bloc/modules/splash/splash_page.dart';
import 'package:base_bloc/modules/tab_home/tab_home.dart';
import 'package:base_bloc/modules/tab_race/tab_race.dart';
import 'package:fluro/fluro.dart';

import '../modules/tab_athlete/tab_athlete.dart';
import '../modules/tab_news/tab_news.dart';

var routeHome = Handler(handlerFunc: (c, p) => const HomePage());
var routeSplash = Handler(handlerFunc: (c, p) => const SplashPage());
var routeTabHome = Handler(handlerFunc: (c, p) => const TabHome());
var routeTabRace = Handler(handlerFunc: (c, p) => const TabRace());
var routeTabAthlete = Handler(handlerFunc: (c, p) => const TabAthlete());
var routeTabNews = Handler(handlerFunc: (c, p) => const TabNews());
var routeTournamentDetail = Handler(
    handlerFunc: (c, p) => RaceDetailPage(
          model: (c!.settings!.arguments as List)[0],
          root: (c.settings!.arguments as List)[1],
        ));
var routeAthleteDetail = Handler(
    handlerFunc: (c, p) => AthleteDetailPage(
          model: (c!.settings!.arguments as List)[0],
          root: (c.settings!.arguments as List)[1],
        ));
var routeNewsDetail = Handler(
    handlerFunc: (c, p) => NewsDetailPage(
          model: (c!.settings!.arguments as List)[0],
          root: (c.settings!.arguments as List)[1],
        ));
