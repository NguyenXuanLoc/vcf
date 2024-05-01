import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../data/globals.dart' as globals;
import 'application.dart';

class RouterUtils {
  static Future<dynamic> pushTo(BuildContext? context, Widget newPage,
      {bool isReplace = false, bool isFromBottomTopTop = false}) async {
    if (context == null) return;
    var begin =
        isFromBottomTopTop ? const Offset(0.0, 1.0) : const Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    if (isReplace) {
      return await Navigator.of(context).pushAndRemoveUntil<void>(
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => newPage,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                return SlideTransition(
                    position: animation.drive(tween), child: child);
              }),
          (Route<dynamic> route) => false);
    }
    return await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => newPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          if (animation.status == AnimationStatus.reverse &&
              globals.isQrCode &&
              globals.popWithNewAnimation) {
            var begin = const Offset(0.0, 1.0);
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
                position: animation.drive(tween), child: child);
          }
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  static push<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.router.navigateTo(context, route,
        transition: TransitionType.inFromBottom,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static Future<T> pushHome<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.routerHome.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static Future<T> pushRace<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.routerRace.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static Future<T> pushAthlete<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.routerAthlete.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }

  static Future<T> pushNews<T>(
      {required BuildContext context,
      required String route,
      dynamic argument,
      bool isRemove = false}) async {
    T result = await Application.routerNews.navigateTo(context, route,
        transition: TransitionType.inFromRight,
        clearStack: isRemove,
        routeSettings: RouteSettings(arguments: argument));
    return result;
  }
}
