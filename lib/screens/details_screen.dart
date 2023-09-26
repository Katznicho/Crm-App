import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_button/fx_block_button.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_svg_icon.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_v_spacer.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_template/default_template/components/fx_card_header.dart';
import 'package:fx_flutterap_template/default_template/components/fx_page_header.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_text_field/fx_text_field_form.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_text_field/fx_text_field.dart';
import 'package:crm_app/screens/collections_card.dart';
import 'package:crm_app/utils/utilities.dart';

import '../controllers/FormController.dart';
import '../utils/constants/app_constants.dart';
import 'add_data_page.dart';
import 'components/form_field.dart';
import 'layout/admin_panel_layout.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  final List? collectionDetails;
  final List<dynamic>? collectionPermissions;
  bool isEditable = true;
  final String collectionName;

  DetailsScreen(
      {Key? key,
      required this.data,
      required this.collectionDetails,
      required this.collectionPermissions,
      required this.collectionName});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Map<String, dynamic> formData = {};

  void updateFormData(String key, String value) {
    setState(() {
      formData[key] = value;
    });
  }

  @override
  void initState() {
    super.initState();

    print("=================data details================");

    for (final entry in widget.collectionDetails?[0]['formObject']
        ['components']) {
      final label = entry['label'];
      var key = entry['key'];

      if (label != null &&
          label != "Submit" &&
          label != "submit" &&
          label != "Reset" &&
          label != "reset") {
        // Check if the key exists in widget.data and assign its value to formData[key]
        if (widget.data.containsKey(key)) {
          formData[key] = widget.data[key];
        } else {
          // If the key doesn't exist in widget.data, initialize it as null
          formData[key] = null;
        }
      }
    }

    print("=============form Data=========================");
    print(formData);
    print("=============form Data==================");
  }

  bool isEditable = true;
  @override
  Widget build(BuildContext context) {
    // Define a list to hold the AppBar actions based on permissions

    List<Widget> appBarActions = [];
    if (widget.collectionPermissions!.isEmpty) {
    } else {
      // Check if the user has the "create" permission for a specific collection
      bool hasCretaePermission =
          widget.collectionPermissions?[0]["permissions"].contains("create");
      if (hasCretaePermission) {
        appBarActions.add(
          GestureDetector(
            onTap: () {
              // Navigate to the "Add Data" page and set properties
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => AdminPanelLayout(
                          child: AddDataPage(
                            collectionDetails: widget.collectionDetails,
                            collectionName: widget.collectionName,
                          ),
                        )),
              );
            },
            child: IconButton(
              icon: FxSvgIcon(
                "packages/fx_flutterap_components/assets/svgs/add.svg",
                color: InitialStyle.icon,
                size: InitialDims.icon5,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => AdminPanelLayout(
                            child: AddDataPage(
                              collectionDetails: widget.collectionDetails,
                              collectionName: widget.collectionName,
                            ),
                          )),
                );
              },
            ),
          ),
        );
      }
      // Check if the user has the "update" permission for a specific collection
      bool hasUpdatePermission =
          widget.collectionPermissions?[0]["permissions"].contains("update");
      if (hasUpdatePermission) {
        setState(() {
          isEditable = false;
        });
        appBarActions.add(
          IconButton(
            icon: FxSvgIcon(
              "packages/fx_flutterap_components/assets/svgs/Pencil.svg",
              color: InitialStyle.icon,
              size: InitialDims.icon5,
            ),
            onPressed: () {
              setState(() {
                isEditable = false;
              });
            },
          ),
        );
      }

      // Check if the user has the "delete" permission for a specific collection
      bool hasDeletePermission =
          widget.collectionPermissions?[0]["permissions"].contains("delete");
      if (hasDeletePermission) {
        appBarActions.add(IconButton(
          icon: FxSvgIcon(
            "packages/fx_flutterap_components/assets/svgs/cross.svg",
            color: InitialStyle.dangerColorDark,
            size: InitialDims.icon5,
          ),
          onPressed: () {},
        ));
      }
    }

    return Scaffold(
      backgroundColor: InitialStyle.background,
      appBar: AppBar(
        title: const FxPageHeader(title: 'Details'),
        backgroundColor: InitialStyle.background,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the color of the arrow back icon
        ),
        actions: appBarActions,
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
