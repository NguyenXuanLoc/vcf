import 'package:flutter/cupertino.dart';

import '../theme/app_styles.dart';
import '../theme/colors.dart';
import 'app_text.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final double? size;

  const TitleWidget({super.key, required this.title, this.size});

  @override
  Widget build(BuildContext context) {
    return AppText(title,
        style: typoW700.copyWith(fontSize: size ?? 24, color: colorWhite));
  }
}
