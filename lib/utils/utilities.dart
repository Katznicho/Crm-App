import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_drop_down/fx_drop_down.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_text_field/fx_text_field.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_text_field/fx_text_field_form.dart';
import 'package:fx_flutterap_template/default_template/components/fx_card_decoration.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:uuid/uuid.dart';
import '../../theme/theme.dart';
import '../controllers/FormController.dart';

class Utils {
  String humanize(String s) {
    return s
        .replaceAll('_', ' ') // replace underscores with spaces
        .split(' ') // split string by space
        .map((word) => word.isNotEmpty
            ? // convert each word to title case
            word[0].toUpperCase() +
                word.substring(1).replaceAllMapped(
                      RegExp('([A-Z])'),
                      (match) => ' ${match.group(1)}',
                    )
            : '')
        .join(' '); // join words back together with space
  }

  DateTime getDateTime(String d) {
    return DateFormat('yyyy-MM-dd').parse(d);
  }

  String dateStringFormatter(String d) {
    return DateFormat('MMM dd, yyyy').format(DateFormat('yyyy-MM-dd').parse(d));
  }

  String dateTimeFormatter(DateTime d) {
    return DateFormat('MMM dd, yyyy').format(d);
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  progressIndicator() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30.0,
              width: 30.0,
              child: CircularProgressIndicator(color: BivatecGreen),
            ),
          ],
        ),
      ),
    );
  }

  errorText({required String message}) {
    return Container(
        child: Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.all(30.0),
        child: Text(message, style: ErrorTextStyle),
      ),
    ));
  }

  Widget button(
      {required String text,
      Widget? prefix,
      Widget? suffix,
      required onPressed,
      double borderRadius = 5.0,
      double padding = 5.0,
      double fontSize = 14,
      FontWeight fontWeight = FontWeight.normal,
      Color? color = PrimaryColor,
      Color textColor = TextColor}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color,
          //background color of button//border width and color
          backgroundColor: color,
          elevation: 1,
          //elevation of button
          shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.circular(borderRadius)),
          padding: EdgeInsets.all(padding) //content padding inside button
          ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          (prefix != null) ? prefix : const SizedBox.shrink(),
          (prefix != null)
              ? const SizedBox(width: 10)
              : const SizedBox.shrink(),
          Text(text,
              style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight)),
          (suffix != null)
              ? const SizedBox(width: 10)
              : const SizedBox.shrink(),
          (suffix != null) ? suffix : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget text(
      {required String text,
      required double alignLeft,
      double fontSize = MediumTextSize,
      Color textColor = TextColor}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: alignLeft),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget requiredText({text, required double alignLeft}) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            margin: EdgeInsets.only(left: alignLeft),
            child: Text.rich(
              TextSpan(
                text: text,
                children: const <InlineSpan>[
                  TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
                style: const TextStyle(
                  fontSize: MediumTextSize,
                  color: TextColor,
                ),
              ),
            )));
  }

  Future<bool> confirmAppExit(context) async {
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Exit App'),
                content: const Text('Are you sure you want to exit the app?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                  TextButton(
                    child: const Text('Confirm'),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ],
              );
            }) ??
        false; // This will return false if the dialog returns null
  }

  String getFileName({required String path}) {
    return p.basename(path);
  }

  String getFileExtension({required String path}) {
    return p.extension(path);
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitDays = twoDigits(duration.inDays);
    String twoDigitHours = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigitDays != "00")
      return "$twoDigitDays days ago";
    else if (twoDigitHours != "00")
      return "$twoDigitHours hrs ago";
    else if (twoDigitMinutes != "00")
      return "$twoDigitMinutes mins ago";
    else if (twoDigitSeconds != "00") return "$twoDigitSeconds secs ago";
    return "$twoDigitSeconds secs ago";
  }

  bool isExpired(String date) {
    bool isExpired = false;
    try {
      final now = DateTime.now();
      final expirationDate = DateTime.parse(date);
      isExpired = expirationDate.isBefore(now);
    } catch (e) {
      FlutterLogs.logError("Date", "Error", e.toString());
    }
    return isExpired;
  }

  List<int> _getValues(List items) {
    List<int> values = [];
    int count = 0;
    items.forEach((element) {
      values.add(count);
      count++;
    });
    return values;
  }

  myTextfield(
      {required Widget widget,
      required String question,
      bool isRequired = false}) {
    return Column(
      children: [
        (isRequired)
            ? Utils().requiredText(text: question, alignLeft: 15.0)
            : Utils().text(text: question, alignLeft: 15.0),
        const SizedBox(
          height: 10,
        ),
        widget,
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  switchButton(bool isSwitched, dynamic toggleSwitch) {
    return Transform.scale(
        scale: 1.5,
        child: Switch(
          onChanged: toggleSwitch,
          value: isSwitched,
          activeColor: Colors.white,
          activeTrackColor: BivatecOrange,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: GreyA,
        ));
  }

  Widget menuCard(BuildContext context, String title,
      {required Function() onTap, Widget? icon, String? imagePath}) {
    return Expanded(
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (icon != null)
                  ? icon
                  : Image.asset(
                      imagePath!,
                      height: 64.0,
                      width: 64.0,
                    ),
              const SizedBox(height: 16.0),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reportsCard(BuildContext context, String title,
      {Widget? icon,
      String? imagePath,
      required List<Color> colors,
      required Function() onTap}) {
    return Expanded(
      child: Card(
        elevation: 1.0,
        margin: const EdgeInsets.all(5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (icon != null)
                    ? icon
                    : Image.asset(
                        imagePath!,
                        height: 58.0,
                        width: 58.0,
                      ),
                const SizedBox(height: 1.0),
                Text(title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    )),
                const SizedBox(height: 3.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDeletePopup(
      {required BuildContext context,
      required String title,
      required String description,
      required Function onDelete}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Utils().button(
                  text: 'Cancel',
                  color: BivatecOrange,
                  textColor: White,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 5),
                Utils().button(
                    text: 'Delete',
                    color: DangerColor,
                    textColor: White,
                    onPressed: () {
                      onDelete();
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ],
        );
      },
    );
  }

  showPromptPopup(
      {required BuildContext context,
      required String title,
      required String description,
      required Function onOkay}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Utils().button(
                  text: 'Cancel',
                  color: BivatecOrange,
                  textColor: White,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 5),
                Utils().button(
                    text: 'Okay',
                    color: BivatecGreen,
                    textColor: White,
                    onPressed: () {
                      onOkay();
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ],
        );
      },
    );
  }

  String mapKeyToLabel(List<dynamic>? fields, String key) {
    for (var field in fields!) {
      if (field['_id'] == key || field['key'] == key) {
        return field['displayText'] ??
            field['label'] ??
            field['_id'] ??
            field['key'];
      }
    }
    return key;
  }

  Map<String, dynamic> getFieldType(List<dynamic>? fields, String key) {
    for (var field in fields!) {
      if (field['_id'] == key || field['key'] == key) {
        return field;
      }
    }
    return {"type": "textfield", "hidden": "false", "mandatory": "false"};
  }

  BootstrapCol cardShow5(Widget widget) {
    return BootstrapCol(
        sizes: 'col-sm-12 col-ml-12 col-lg-6 col-xl-6',
        child: Container(
            margin: FxCardDecoration().cardShowMargin, child: widget));
  }

  Widget cardShow(Widget widget) {
    return BootstrapCol(
        sizes: 'col-sm-12 col-ml-12 col-lg-6 col-xl-4', child: widget);
  }

  String convertToCamelCase(String input) {
    // Split the input string into words
    final words = input.split(' ');

    // Capitalize the first letter of each word except the first one
    final capitalizedWords = words.map((word) {
      if (word.isEmpty) {
        return ' '; // Skip empty words
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    // Join the words back together to form camel case
    final camelCaseString = capitalizedWords.join(' ');

    // Make sure the first letter is in lowercase
    return camelCaseString[0].toUpperCase() + camelCaseString.substring(1);
  }

  Widget buildValueFormField(
      dynamic value, List<dynamic>? fields, dynamic key, bool isEditable) {
    Map<String, dynamic> details = Utils().getFieldType(fields, key);

    if (value == null) {
      return Container();
    }
    // Declare controllers for different data types
    TextEditingController textController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    // ValueNotifier<bool> booleanController = ValueNotifier<bool>(value);

    if (details['type'] == "textfield") {
      textController.text = value.toString(); // Set the initial value
      return FxTextFieldForm(
        controller: textController,
        hint: value.toString(),
        disabled: isEditable,
      );
    } else if (details['type'] == "number") {
      numberController.text = value.toString(); // Set the initial value
      return FxTextField(
        controller: numberController,
        hint: 'Enter a number',
        textInput: TextInputType.number,
        disabled: true,
      );
    } else {
      // Handle other data types or return a default form field
      textController.text = value.toString(); // Set the initial value
      return FxTextFieldForm(
        controller: textController,
        hint: value.toString(),
        disabled: isEditable,
      );
    }
  }

// Function to generate a unique ID (you can use a UUID package or any method you prefer)
  String generateUniqueId() {
    const uuid = Uuid();
    return uuid.v4();
  }
}
