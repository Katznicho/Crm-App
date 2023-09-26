import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_button/fx_information_button.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_icon_text.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';

import '../structure/structure_dims.dart';
import '../structure/structure_styles.dart';

class FxCardHeader extends StatelessWidget {
  final String title;
  final String? information;
  final GlobalKey? informationKey;
  final bool isBold;
  final bool isSizeBig;

  const FxCardHeader(
      {Key? key,
      required this.title,
      this.information,
      this.informationKey,
      this.isBold = true,
      this.isSizeBig = false})
      : super(key: key);

  //        fontSize: size ?? fontSize(tag ?? Tag.h4),

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FxIconText(
            title,
            color: InitialStyle.titleTextColor,
            size: isSizeBig
                ? InitialDims.highTitleFontSize
                : InitialDims.normalFontSize,
            isBold: isBold,
            // icon: Icon(
            //   Icons.circle,
            //   size: InitialDims.icon1,
            //   color: InitialStyle.primaryColor,
            // ),
          ),
        ),
        information == null
            ? Container()
            : FxText(
                information!,
                size: InitialDims.normalFontSize,
                overFlowTag: true,
              ),
      ],
    );
  }
}
