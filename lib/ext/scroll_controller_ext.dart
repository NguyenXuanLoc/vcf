import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

extension ScrollControllerExt on ScrollController {
  void paging(VoidCallback paging) {
    addListener(() {
      var maxScroll = position.maxScrollExtent;
      var currentScroll = position.pixels;
      if (maxScroll - currentScroll <= 200 &&
          position.userScrollDirection == ScrollDirection.reverse) {
        paging.call();
      }
    });
  }
}
