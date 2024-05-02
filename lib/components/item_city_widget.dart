import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/data/model/city_model.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/material.dart';

import '../base/hex_color.dart';

class ItemFilterWidget extends StatelessWidget {
  final String content;
  final bool isSelect;
  final VoidCallback itemOnClick;

  const ItemFilterWidget(
      {required this.itemOnClick,
      super.key,
      required this.content,
      required this.isSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: () => itemOnClick.call(),
        borderRadius: BorderRadius.circular(100),
        child: Container(
            decoration: BoxDecoration(
                gradient: isSelect
                    ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [HexColor('38BAEA'), HexColor('4869F0')])
                    : null,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    color: isSelect ? colorTransparent : colorWhite)),
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
            child: AppText(content ?? '',
                style: typoW400.copyWith(fontSize: 12, color: colorWhite))),
      ),
    );
  }
}
