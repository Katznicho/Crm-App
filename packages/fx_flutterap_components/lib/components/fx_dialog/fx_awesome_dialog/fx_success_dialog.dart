import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_button/fx_button.dart';

import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';

class FxSuccessDialog extends StatelessWidget {
  final String text;
  final String title;
  final String desc;
  final Color? colorAsset;
  final Color? buttonFontColor;

  const FxSuccessDialog(
      {Key? key,
      required this.text,
      required this.title,
      required this.desc,
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
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          title: title,
          desc: desc,
          btnOkOnPress: () {},
          btnOkIcon: Icons.check_circle,
          // onDissmissCallback: () {
          //   debugPrint('Dialog Dissmiss from callback');
          // }
        ).show();
      },
    ));
  }
}
