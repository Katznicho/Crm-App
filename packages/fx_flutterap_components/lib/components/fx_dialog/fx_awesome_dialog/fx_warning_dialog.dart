import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_button/fx_button.dart';

import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';

class FxWarningDialog extends StatelessWidget {
  final String text;
  final String title;
  final String desc;
  final Color? colorAsset;
  final Color? buttonFontColor;
  final VoidCallback btnCancelOnPress;
  final VoidCallback btnOkOnPress;

  const FxWarningDialog(
      {Key? key,
      required this.text,
      required this.title,
      required this.desc,
      required this.btnCancelOnPress,
      required this.btnOkOnPress,
      this.colorAsset,
      this.buttonFontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FxButton(
      text: text,
      fillColor: colorAsset,
      textColor: buttonFontColor ?? InitialStyle.textColor,
      onTap: () {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                headerAnimationLoop: false,
                animType: AnimType.topSlide,
                showCloseIcon: true,
                closeIcon: const Icon(Icons.close_fullscreen_outlined),
                title: text,
                desc: desc,
                btnCancelOnPress: () {},
                btnOkOnPress: () {})
            .show();
      },
    ));
  }
}
