import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';

import '../../fx_form/fx_text_field/fx_text_field.dart';

class FxInputDialog extends StatelessWidget {
  final String text;
  final String title;
  final String desc;
  final Color? colorAsset;
  final Color? buttonFontColor;
  final FxTextField fxTextField1;
  final FxTextField fxTextField2;

  const FxInputDialog({
    Key? key,
    required this.text,
    required this.title,
    required this.desc,
    required this.fxTextField1,
    required this.fxTextField2,
    this.colorAsset,
    this.buttonFontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedButton(
      width: InitialDims.space25,
      height: InitialDims.space5,
      text: text,
      color: colorAsset,
      // buttonFontColor: widget.buttonFontColor,
      pressEvent: () {},
    ));
  }
}
