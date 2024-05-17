import 'package:flutter/cupertino.dart';

import '../theme/colors.dart';

class LineWidget extends StatelessWidget {
  final Color? color;

  const LineWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 1,
        color: color ?? colorWhite.withOpacity(0.12));
  }
}
