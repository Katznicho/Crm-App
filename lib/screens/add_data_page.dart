// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_button/fx_block_button.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_v_spacer.dart';
import 'package:fx_flutterap_template/default_template/components/fx_card_header.dart';
import 'package:fx_flutterap_template/default_template/components/fx_page_header.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:crm_app/controllers/FormController.dart';
import 'package:crm_app/utils/constants/app_constants.dart';

import '../utils/utilities.dart';
import 'components/form_field.dart';

class AddDataPage extends StatefulWidget {
  final String collectionName;
  List<dynamic>? collectionDetails;
  // Map<String, dynamic> formData = {};

  // ignore: use_key_in_widget_constructors
  AddDataPage({
    required this.collectionName,
    required this.collectionDetails,
  });

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  Map<String, dynamic> formData = {};

  void updateFormData(String key, String value) {
    setState(() {
      formData[key] = value;
    });
  }

  @override
  void initState() {
    super.initState();

    // Initialize formData with empty strings for each component label
    for (final entry in widget.collectionDetails?[0]['formObject']
        ['components']) {
      final label = entry['label'];

      var key = entry['key'];

      if (label != null &&
          label != "Submit" &&
          label != "submit" &&
          label != "Reset" &&
          label != "reset") {
        formData[key] = "";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InitialStyle.background,
      appBar: AppBar(
        title: FxPageHeader(title: "${widget.collectionName} Form"),
        backgroundColor: InitialStyle.background,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the color of the arrow back icon
        ),
      ),
      body: Material(
        color: InitialStyle.background,
        child: Container(
          margin: EdgeInsets.all(InitialDims.space2),
          decoration: BoxDecoration(
            color: InitialStyle.cardColor,
            borderRadius:
                BorderRadius.all(Radius.circular(InitialDims.border3)),
            boxShadow: [
              BoxShadow(
                color: InitialStyle.shadow,
                blurRadius: InitialDims.space5,
              ),
            ],
          ),
          child: ListView.builder(
            itemCount:
                widget.collectionDetails?[0]['formObject']['components'].length,
            itemBuilder: (context, index) {
              final entry = widget.collectionDetails?[0]['formObject']
                  ['components'][index];

              if (index + 1 ==
                  widget.collectionDetails?[0]['formObject']['components']
                      .length) {
                return Container(
                  margin: EdgeInsets.all(InitialDims.space6),
                  child:
                      // Save Button
                      FxBlockButton(
                    text: "Save",
                    fillColor: Colors.transparent,
                    borderColor: InitialStyle.informationColorDark,
                    textColor: InitialStyle.informationColorDark,
                    clickable: true,
                    useShadow: true,
                    size: 18.0,
                    onTap: () async {
                      try {
                        bool allFieldsFilled = true;
                        formData.forEach((key, value) {
                          if (value == null || value.toString().isEmpty) {
                            allFieldsFilled = false;
                            // Display a message that all fields are required
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("The  $key field is required."),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            return; // Exit the forEach loop early
                          }
                        });

                        if (allFieldsFilled) {
                          String uniqueId = Utils().generateUniqueId();
                          // Add the _id and mobileStatus fields to formData
                          formData["_id"] = uniqueId;
                          formData["mobileStatus"] = AppConstants.NEW;
                          List<dynamic> data = [];
                          data.add(formData);
                          await FormController().storeFormItems(data,
                              store: widget.collectionName);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("The data has been added"),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } else {
                          // Not all fields are filled, do not save data
                        }
                      } catch (e) {
                        print("===========================");
                        print(e);
                        print("===========================");
                      }
                    },
                  ),
                );
              }

              // Check if entry['label'] is "button" or "reset"
              if (entry['label'] == "submit" ||
                  entry['label'] == "Submit" ||
                  entry['label'] == "reset" ||
                  entry['label'] == "Reset") {
                // Continue processing
                return Container();
              }

              // Create a controller for text fields and store it in the Map
              if (entry['type'] == "textfield") {}

              return Container(
                child: Utils().cardShow(Column(
                  children: [
                    ListTile(
                        title: FxCardHeader(
                            title: Utils().convertToCamelCase(entry['label'])),
                        subtitle: MyFormFieldWidget(
                          fields: entry,
                          formData: formData,
                          updateFormData:
                              updateFormData, //Pass the callback function
                        )),
                    // Add a button as the last item in the Column
                    const FxVSpacer(),
                    // Add a vertical spacer
                  ],
                )),
              );
            },
          ),
        ),
      ),
    );
  }
}
