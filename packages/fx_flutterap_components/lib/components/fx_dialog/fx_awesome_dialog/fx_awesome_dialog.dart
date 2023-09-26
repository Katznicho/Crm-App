import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class FxAwesomeDialog extends StatelessWidget {
  const FxAwesomeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AnimatedButton(
              text: 'Info Dialog',
              pressEvent: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                  buttonsBorderRadius:
                      const BorderRadius.all(Radius.circular(2)),
                  headerAnimationLoop: false,
                  animType: AnimType.bottomSlide,
                  title: 'INFO',
                  desc: 'Dialog description here...',
                  showCloseIcon: true,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AnimatedButton(
              text: 'Warning Dialog',
              color: Colors.orange,
              pressEvent: () {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        headerAnimationLoop: false,
                        animType: AnimType.topSlide,
                        showCloseIcon: true,
                        closeIcon: const Icon(Icons.close_fullscreen_outlined),
                        title: 'Warning',
                        desc: 'Dialog description here',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {})
                    .show();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AnimatedButton(
              text: 'Error Dialog',
              color: Colors.red,
              pressEvent: () {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        headerAnimationLoop: false,
                        title: 'Error',
                        desc: 'Dialog description here',
                        btnOkOnPress: () {},
                        btnOkIcon: Icons.cancel,
                        btnOkColor: Colors.red)
                    .show();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AnimatedButton(
              text: 'Succes Dialog',
              color: Colors.green,
              pressEvent: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.leftSlide,
                  headerAnimationLoop: false,
                  dialogType: DialogType.success,
                  title: 'Succes',
                  desc: 'Dialog description here',
                  btnOkOnPress: () {
                    debugPrint('OnClcik');
                  },
                  btnOkIcon: Icons.check_circle,
                  // onDissmissCallback: () {
                  //   debugPrint('Dialog Dissmiss from callback');
                  // }
                ).show();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AnimatedButton(
              text: 'No Header Dialog',
              color: Colors.cyan,
              pressEvent: () {
                AwesomeDialog(
                  context: context,
                  headerAnimationLoop: false,
                  dialogType: DialogType.noHeader,
                  title: 'No Header',
                  desc: 'Dialog description here',
                  btnOkOnPress: () {
                    debugPrint('OnClcik');
                  },
                  btnOkIcon: Icons.check_circle,
                ).show();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AnimatedButton(
              text: 'Custom Body Dialog',
              color: Colors.blueGrey,
              pressEvent: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.info,
                  body: const Center(
                    child: Text(
                      'If the body is specified, then title and description will be ignored, this allows to further customize the dialogue.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  title: 'This is Ignored',
                  desc: 'This is also Ignored',
                ).show();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AnimatedButton(
              text: 'Auto Hide Dialog',
              color: Colors.purple,
              pressEvent: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.scale,
                  title: 'Auto Hide Dialog',
                  desc: 'AutoHide after 2 seconds',
                  autoHide: const Duration(seconds: 2),
                ).show();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            AnimatedButton(
              text: 'Body with Input',
              color: Colors.blueGrey,
              pressEvent: () {},
            ),
          ],
        ),
      ),
    )));
  }
}
