import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_drop_down/fx_drop_down.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_text_field/fx_text_field.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_text_field/fx_text_field_form.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';

import '../../controllers/FormController.dart';

class MyFormFieldWidget extends StatefulWidget {
  Map<String, dynamic>? fields;
  Map<String, dynamic> formData;
  Function(String key, String value)
      updateFormData; // Declare the callback function parameter

  MyFormFieldWidget({
    super.key,
    required this.fields,
    required this.formData,
    required this.updateFormData, //
  });
  @override
  _MyFormFieldWidgetState createState() => _MyFormFieldWidgetState();
}

class _MyFormFieldWidgetState extends State<MyFormFieldWidget> {
  ValueNotifier<List<Map<String, dynamic>>> _dropdownData =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  // Declare a state variable for the dropdown value
  String dropdownValue = "";

  @override
  void initState() {
    super.initState();
    if (widget.fields?['type'] == "select" && _dropdownData.value.isEmpty) {
      if (widget.fields?['properties'] != null &&
          widget.fields?['properties'].isNotEmpty) {
        String collectionName = widget.fields?['properties']['collection'];

        fetchData(collectionName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? fields = widget.fields;

    if (fields?['type'] == "textfield") {
      return FxTextFieldForm(
          hint: "Enter ${fields?['label']}",
          onChanged: (enteredText) {
            widget.updateFormData(fields?['key'], enteredText);
          });
    } else if (fields?['type'] == "number") {
      return FxTextField(
        hint: "Enter ${fields?['label']}",
        textInput: TextInputType.phone,
        onChanged: (enteredNumber) {
          widget.updateFormData(fields?['key'], enteredNumber);
        },
      );
    } else if (fields?['type'] == "select") {
      String trimmedValue = fields?['label'].trim();
      trimmedValue = trimmedValue.length > 30
          ? "${trimmedValue.substring(0, 22)}..."
          : trimmedValue;

      if (fields?['properties'] != null && fields?['properties'].isNotEmpty) {
        if (_dropdownData.value.isEmpty) {
          String collectionName = widget.fields?['properties']['collection'];

          fetchData(collectionName);
        }

        String valueNameField = fields?['properties']['dbKey'];
        String keyValue = fields?['key'];

        return ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: _dropdownData,
          builder: (context, data, child) {
            if (data.isEmpty) {
              return const CircularProgressIndicator();
            } else {
              String trimmedValue = fields?['label'].trim();
              trimmedValue = trimmedValue.length > 30
                  ? "${trimmedValue.substring(0, 22)}..."
                  : trimmedValue;

              List<Map<String, dynamic>> details = _dropdownData.value;

              // List<Map<String, dynamic>> modifiedDetails = [];

              // for (var map in details) {
              //   String valueName = map[valueNameField];
              //   map[keyValue] = valueName; // Add keyValue to the existing map
              //   modifiedDetails
              //       .add(map); // Add the modified map to the new list
              // }

              return IntrinsicWidth(
                child: FxDropDown(
                  initialTitle: "Select $trimmedValue",
                  list: details,
                  value: widget.formData[fields?["key"]] ?? "",
                  idName: "refID",
                  valueName: valueNameField,
                  onChanged: (selectedValue) {
                    widget.updateFormData(fields?['key'], selectedValue);
                  },
                  dropdownWidth: 300.0,
                  buttonPadding: EdgeInsets.symmetric(
                    vertical: InitialDims.space2,
                    horizontal: InitialDims.space15,
                  ),
                ),
              );
            }
          },
        );
      } else {
        List<dynamic> items = fields?['values']?.toList() ??
            []; // Create a mutable copy of the list
        dropdownValue = items[0]["value"];

        return IntrinsicWidth(
          child: FxDropDown(
            initialTitle: "Select $trimmedValue",
            list: items,
            value: widget.formData[fields?["key"]] ?? "",
            valueName: "label",
            idName: "value",
            dropdownWidth: 300.0,
            onChanged: (selectedValue) {
              widget.updateFormData(fields?['key'], selectedValue);
            },
            buttonPadding: EdgeInsets.symmetric(
              vertical: InitialDims.space2,
              horizontal: InitialDims.space15,
            ),
          ),
        );
      }
    } else {
      return FxTextFieldForm(
        hint: "Enter ${fields?['label']}",
        onChanged: (enteredText) {
          setState(() {
            widget.formData[fields?['label']] = enteredText;
          });
        },
      );
    }
  }

  Future<void> fetchData(String collectionName) async {
    final data =
        await FormController().getFormsFromSembast(store: collectionName);
    setState(() {
      _dropdownData.value = List<Map<String, dynamic>>.from(data);
    });
  }
}
