import 'package:flutter/cupertino.dart';

import '../theme/colors.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 1,
        color: colorWhite.withOpacity(0.12));
  }
}
