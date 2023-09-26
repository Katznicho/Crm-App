import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_checkbox/fx_custom_check_box.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_editable_components/editable_components/fx_dashboard_card/fx_tickets_card.dart';
import 'package:fx_flutterap_template/default_template/components/fx_card_decoration.dart';
import 'package:fx_flutterap_template/default_template/components/fx_card_header.dart';
import 'package:fx_flutterap_template/default_template/components/fx_page_header.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:crm_app/utils/constants/collections.dart';

import '../controllers/FormController.dart';
import 'generic_data_renderer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    String collectionName = args?["collectionName"];
    String title = args?["title"];

    return Scaffold(
      backgroundColor: InitialStyle.background,
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          FormController().getFormsFromSembast(store: collectionName),
          FormController()
              .getSpecificollectionDetailsFromSembast(collectionName),
          FormController().getSpecificollectionDetailsFromSembast(
              collectionName,
              store: CollectionConstants.FORMPERMISSIONS)
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the Future is still running, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there is an error, show an error message
            return Center(child: FxText('Error: ${snapshot.error.toString()}'));
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Center(
              child: Container(
                  margin: EdgeInsets.all(InitialDims.space3),
                  padding: EdgeInsets.symmetric(
                    vertical: InitialDims.space3,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(InitialDims.space3),
                    child: FxCardHeader(
                      title: "No $collectionName data available",
                      isBold: true,
                      isSizeBig: true,
                    ),
                  )),
            );
          } else {
            // If data is available, render it using the GenericDataRenderer
            List<dynamic> data = snapshot.data!;
            List<dynamic> forms = data[0];
            List<dynamic> collectionDetails = data[1];
            List<dynamic> collectionPermissions = data[2];
            if (forms.isEmpty) {
              return Center(
                child: Container(
                    margin: EdgeInsets.all(InitialDims.space3),
                    padding: EdgeInsets.symmetric(
                      vertical: InitialDims.space3,
                    ),
                    child: Container(
                      margin: EdgeInsets.all(InitialDims.space3),
                      child: FxCardHeader(
                        title: "No $collectionName data available",
                        isBold: true,
                        isSizeBig: true,
                      ),
                    )),
              );
            }
            return GenericDataRenderer(
                data: forms,
                title: title,
                collectionDetails: collectionDetails,
                collectionPermissions: collectionPermissions,
                collectionName: collectionName);
          }
        },
      ),
    );
  }
}
