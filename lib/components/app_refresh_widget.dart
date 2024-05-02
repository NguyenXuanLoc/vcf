import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/material.dart';

class AppRefreshWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  final Widget child;

  const AppRefreshWidget(
      {Key? key, required this.onRefresh, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: colorPrimaryBrand100,
        child: child,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 400));
          onRefresh.call();
        });
  }
}
