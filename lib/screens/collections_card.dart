import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:fx_flutterap_components/components/fx_label/fx_content_label.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_editable_components/editable_components/fx_dashboard_card/fx_statistic_card_1.dart';
import 'package:fx_flutterap_template/default_template/components/fx_container_items.dart';
import 'package:crm_app/screens/collection_form.dart';

import '../controllers/FormController.dart';
import 'dart:collection';

class CollectionDetails extends StatefulWidget {
  final Map<String, dynamic> collectionData;

  CollectionDetails({required this.collectionData});

  @override
  State<CollectionDetails> createState() => _CollectionDetailsState();
}

class _CollectionDetailsState extends State<CollectionDetails> {
  @override
  Widget build(BuildContext context) {
    //  List<Map<String, dynamic>> fieldData = widget.collectionData['fields'];

    List<Map<String, dynamic>> fieldData =
        (widget.collectionData['fields'] as List<dynamic>)
            .cast<Map<String, dynamic>>();

    List<Widget> fieldWidgets =
        widget.collectionData['fields'].map<Widget>((field) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxContentLabel(
            text: field['label'] ?? '',
            size: 10,
          ),
          SizedBox(height: 8),
          FxText(
            field['type'] ?? '',
            color: Colors.black87,
            size: 14,
            align: TextAlign.start,
          ),
          SizedBox(height: 16),
        ],
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Collection Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context); // Navigate back to Collections page
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText(
              widget.collectionData['collectionName'] ?? '',
              tag: Tag.h3,
              color: Colors.blue,
              size: 24,
              align: TextAlign.start,
            ),
            SizedBox(height: 16),
            CollectionDetailsForm(
              fieldData: fieldData,
            ),
            // Use FxStatisticCard1 to display the fieldWidgets
            FxStatisticCard1(
              displayText: widget.collectionData['collectionType'] ??
                  'lorem ipsum lorem ipsum',
              number: widget.collectionData['collectionName'] ?? 'Total income',
              customContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: fieldWidgets,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Collections extends StatefulWidget {
  const Collections({Key? key}) : super(key: key);

  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  late Future<List<dynamic>> _formData;

  @override
  void initState() {
    super.initState();
    _formData = FormController().getFormsFromSembast();
  }

  BootstrapCol cardShow1(Widget child) {
    return BootstrapCol(
      sizes: 'col-sm-12 col-ml-12 col-lg-12 col-xl-12',
      child: Container(
        margin: EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  BootstrapCol cardShow2(Widget widget) {
    return BootstrapCol(
      sizes: 'col-sm-12 col-ml-6 col-lg-6 col-xl-3',
      child: Container(
        margin: EdgeInsets.all(16),
        child: widget,
      ),
    );
  }

  Widget dashboardContainerItems({
    required String title,
    required Widget child,
  }) {
    return FxContainerItems(
      title: title,
      margin: EdgeInsets.all(0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Collections"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
          future: _formData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<Map<String, dynamic>> formData =
                  snapshot.data as List<Map<String, dynamic>>;
              return SingleChildScrollView(
                child: cardShow1(
                  dashboardContainerItems(
                    title: "Collection Forms",
                    child: Column(
                      children: formData.map((data) {
                        String collectionName =
                            data['collectionName'] ?? 'Total income';
                        if (collectionName.length > 25) {
                          collectionName =
                              collectionName.substring(0, 25) + '...';
                        }
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CollectionDetails(collectionData: data),
                              ),
                            );
                          },
                          child: cardShow2(
                            FxStatisticCard1(
                              imagePath:
                                  "packages/fx_flutterap_components/assets/svgs/right.svg",
                              number: collectionName,
                              displayText: data['collectionType'] ??
                                  'lorem ipsum lorem ipsum',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }
}
