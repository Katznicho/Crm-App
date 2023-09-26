import 'package:fx_flutterap_components/components/fx_button/fx_button.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';

class FxErrorDialog extends StatefulWidget {
  final String text;
  final String title;
  final String desc;
  final Color? colorAsset;
  final Color? buttonFontColor;

  const FxErrorDialog(
      {Key? key,
      required this.text,
      required this.title,
      required this.desc,
      this.colorAsset,
      this.buttonFontColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FxErrorDialog();
  }
}

class _FxErrorDialog extends State<FxErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FxButton(
      text: widget.text,
      fillColor: widget.colorAsset,
      textColor: widget.buttonFontColor ?? InitialStyle.textColor,
      onTap: () {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                headerAnimationLoop: false,
                title: widget.title,
                desc: widget.desc,
                btnOkOnPress: () {},
                btnOkIcon: Icons.cancel,
                btnOkColor: Colors.red)
            .show();
      },
    ));
  }
}
