import 'package:base_bloc/modules/home_page/home_page.dart';
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
