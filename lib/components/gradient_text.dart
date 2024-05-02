import 'package:flutter/cupertino.dart';

import '../base/hex_color.dart';

class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, this.gradient, this.style});

  final String text;
  final TextStyle? style;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => (gradient ??
              LinearGradient(
                  colors: [HexColor("38BAEA"), HexColor("4869F0")],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter))
          .createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
