import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:fx_flutterap_components/components/fx_label/fx_content_label.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_editable_components/editable_components/fx_dashboard_card/fx_statistic_card_1.dart';
import 'package:fx_flutterap_template/default_template/components/fx_container_items.dart';

import '../controllers/FormController.dart';














class CollectionDetailsForm extends StatefulWidget {
  final List<Map<String, dynamic>> fieldData;

  CollectionDetailsForm({required this.fieldData});

  @override
  _CollectionDetailsFormState createState() => _CollectionDetailsFormState();
}

class _CollectionDetailsFormState extends State<CollectionDetailsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};
  final FormController _formController = FormController(); // Initialize the FormController

@override
Widget build(BuildContext context) {
  return Form(
    key: _formKey,
    child: Column(
      children: widget.fieldData.map<Widget>((field) {
        return buildFormField(field);
      }).toList(),

      
    ),
  );
}



// Place the ElevatedButton outside of the Column
Widget buildSubmitButton() {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        submitForm(); // Call the submitForm method when the button is pressed
      },
      child: Text('Submit Form'),
    ),
  );
}


  

Widget buildFormField(Map<String, dynamic> field) {
  final String fieldType = field['type'] ?? '';
  switch (fieldType) {
    case 'select':
      return buildSelectFormField(field);
    case 'textfield':
      return buildTextFormField(field);
    case 'button':
      return buildButtonField(field);
    case 'radio':
      return buildRadioFormField(field);
    // Add more cases for other field types as needed
    default:
      return SizedBox();
  }
}

Widget buildSelectFormField(Map<String, dynamic> field) {
  final List<dynamic>? options = field['options'] as List<dynamic>?;

  if (options != null) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: field['label']),
      value: formData[field['name']] as String?,
      onChanged: (String? newValue) {
        setState(() {
          formData[field['name']] = newValue;
        });
      },
      items: options
          .map<DropdownMenuItem<String>>((dynamic option) {
            if (option is String) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            } else {
              return DropdownMenuItem<String>(
                value: option.toString(),
                child: Text(option.toString()),
              );
            }
          })
          .toList(),
    );
  } else {
    // Handle the case where options is null (or any other appropriate action)
    return SizedBox();
  }
}

  Widget buildTextFormField(Map<String, dynamic> field) {
    return TextFormField(
      decoration: InputDecoration(labelText: field['label']),
      initialValue: formData[field['name']] as String?,
      onSaved: (String? value) {
        formData[field['name']] = value;
      },
    );
  }

  Widget buildButtonField(Map<String, dynamic> field) {
    return ElevatedButton(
      onPressed: () {
        // Handle button click
      },
      child: Text(field['label']),
    );
  }

  Widget buildRadioFormField(Map<String, dynamic> field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field['label']),
        ...(field['options'] as List<dynamic>).map((dynamic option) {
          if (option is String) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: formData[field['name']] as String?,
              onChanged: (String? newValue) {
                setState(() {
                  formData[field['name']] = newValue;
                });
              },
            );
          }
          return SizedBox(); // Skip non-string options
        }).toList(),
      ],
    );
  }

  // Add methods to handle form submission, deletion, etc.

  // Example form submission method:
  void submitForm() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    
    final success = await _formController.updateForms(
      [formData], // Pass the formData as a list
      collectionType: 'your_collection_type_here', // Specify the collection type
    );
    
    if (success) {
      // Handle success
    } else {
      // Handle failure
    }
  }
}

}
