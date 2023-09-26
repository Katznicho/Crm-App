import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_button/fx_block_button.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_h_divider.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_v_spacer.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_template/default_template/components/fx_card_header.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:crm_app/utils/utilities.dart';
import 'details_screen.dart';
import 'layout/admin_panel_layout.dart';

class DataSearchDelegate extends SearchDelegate<String> {
  final List<dynamic>? data;
  final List<dynamic>? collectionDetails;
  final List<dynamic>? collectionPermissions;
  final String collectionName;
  @override
  final String? searchFieldLabel = "search";

  @override
  // ignore: overridden_fields
  final TextStyle? searchFieldStyle = const TextStyle(decoration: null);

  DataSearchDelegate(this.data, this.collectionDetails,
      this.collectionPermissions, this.collectionName);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: InitialStyle.primaryColor,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: InitialStyle.primaryColor,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  Widget cardShow(Widget widget) {
    return BootstrapCol(
        sizes: 'col-sm-12 col-ml-12 col-lg-6 col-xl-4', child: widget);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        color: InitialStyle.background,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: searchFieldStyle,
        border: InputBorder.none,
        labelStyle: const TextStyle(decoration: null),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<dynamic> searchResults = data
            ?.where((item) =>
                item.toString().toLowerCase().contains(query.toLowerCase()))
            .toList() ??
        [];

    if (searchResults.isEmpty) {
      return cardShow(Center(
        child: Container(
            margin: EdgeInsets.all(InitialDims.space2),
            padding: EdgeInsets.symmetric(
              vertical: InitialDims.space3,
            ),
            decoration: BoxDecoration(
              color: InitialStyle.cardColor,
              borderRadius:
                  BorderRadius.all(Radius.circular((InitialDims.border3))),
              boxShadow: [
                BoxShadow(
                    color: InitialStyle.shadow, blurRadius: InitialDims.space5),
              ],
            ),
            child: const FxCardHeader(
              title: "No Search Results Found",
              isBold: true,
              isSizeBig: true,
            )),
      ));
    }
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final result = searchResults[index];
        return Container(
          color: InitialStyle.background,
          child: ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final item = searchResults[index];

              return GestureDetector(
                  child: Container(
                margin: EdgeInsets.all(InitialDims.space2),
                padding: EdgeInsets.symmetric(
                  vertical: InitialDims.space3,
                ),
                decoration: BoxDecoration(
                  color: InitialStyle.cardColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular((InitialDims.border3))),
                  boxShadow: [
                    BoxShadow(
                        color: InitialStyle.shadow,
                        blurRadius: InitialDims.space5),
                  ],
                ),
                child: ListTile(
                    title: cardShow(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(item),
                      const FxVSpacer(), // Add a vertical spacer
                      FxBlockButton(
                        text: "View More Details",
                        fillColor: Colors.transparent,
                        borderColor: InitialStyle.informationColorDark,
                        textColor: InitialStyle.informationColorDark,
                        clickable: true,
                        useShadow: true,
                        size: 18.0,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AdminPanelLayout(
                                  child: DetailsScreen(
                                data: item,
                                collectionDetails: collectionDetails,
                                collectionPermissions: collectionPermissions,
                                collectionName: collectionName,
                              )),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )),
              ));
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<dynamic> suggestions = data
            ?.where((item) =>
                item.toString().toLowerCase().contains(query.toLowerCase()))
            .toList() ??
        [];

    if (suggestions.isEmpty) {
      return cardShow(Center(
        child: Container(
            margin: EdgeInsets.all(InitialDims.space3),
            padding: EdgeInsets.symmetric(
              vertical: InitialDims.space3,
            ),
            child: Container(
              margin: EdgeInsets.all(InitialDims.space3),
              decoration: BoxDecoration(
                color: InitialStyle.cardColor,
              ),
              child: const FxCardHeader(
                title: "No Search Results Found",
                isBold: true,
                isSizeBig: true,
              ),
            )),
      ));
    }

    return Material(
      color: InitialStyle.background,
      child: Scaffold(
        backgroundColor: InitialStyle.background,
        body: Container(
          color: InitialStyle.background,
          child: ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final item = suggestions[index];

              return GestureDetector(
                  child: Container(
                margin: EdgeInsets.all(InitialDims.space2),
                padding: EdgeInsets.symmetric(
                  vertical: InitialDims.space3,
                ),
                decoration: BoxDecoration(
                  color: InitialStyle.cardColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular((InitialDims.border3))),
                  boxShadow: [
                    BoxShadow(
                        color: InitialStyle.shadow,
                        blurRadius: InitialDims.space5),
                  ],
                ),
                child: ListTile(
                    title: cardShow(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(item),
                      const FxVSpacer(), // Add a vertical spacer
                      FxBlockButton(
                        text: "View More Details",
                        fillColor: Colors.transparent,
                        borderColor: InitialStyle.informationColorDark,
                        textColor: InitialStyle.informationColorDark,
                        clickable: true,
                        useShadow: true,
                        size: 18.0,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AdminPanelLayout(
                                  child: DetailsScreen(
                                data: item,
                                collectionDetails: collectionDetails,
                                collectionPermissions: collectionPermissions,
                                collectionName: collectionName,
                              )),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )),
              ));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(Map<String, dynamic>? item) {
    if (item == null) {
      return const FxText('No Data'); // Return a default text if item is null
    }

    final List<Widget> widgets = [];
    int count = 0;

    for (final entry in item.entries) {
      // Skip the "_id" key
      if (entry.key == '_id') {
        continue;
      }
      if (entry.key == "" || entry.key == null) continue;
      if (entry.value == "" || entry.value == null) continue;
      widgets.add(
        Container(
            padding: EdgeInsets.symmetric(
              vertical: InitialDims.space2,
            ),
            child: cardShow(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            FxCardHeader(
                                title: convertToCamelCase(Utils().mapKeyToLabel(
                                    collectionDetails![0]['fields'],
                                    entry.key)),
                                information: count == 0
                                    ? null
                                    : convertToCamelCase(
                                        _buildValueWidget(entry.value)
                                            .toString()),
                                isBold: false),
                            if (count == 0)
                              FxCardHeader(
                                title: (convertToCamelCase(_buildValueWidget(
                                    entry.value,
                                    trimValue: 15))),
                                information: null,
                                isBold: true,
                                isSizeBig: true,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (count < 4) const FxVSpacer(),
                  if (count < 4) const FxHDivider(),
                ],
              ),
            )),
      );

      count++;
      if (count >= 5) {
        break; // Limit to the first 3 key-value pairs
      }
    }

    return cardShow(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    ));
  }

  String _buildValueWidget(dynamic value, {int trimValue = 30}) {
    if (value == null) {
      return "No Data"; // You can customize the message for null values
    } else if (value is String) {
      // Trim the string and limit it to around 30 characters
      String trimmedValue = value.trim();
      if (trimmedValue.length <= trimValue) {
        return convertToCamelCase(trimmedValue);
      } else {
        return convertToCamelCase("${trimmedValue.substring(0, trimValue)}...");
      }
    } else if (value is int) {
      return convertToCamelCase(value.toString());
    } else if (value is double) {
      return convertToCamelCase(value.toString());
    } else if (value is bool) {
      return convertToCamelCase(value.toString());
    } else {
      return convertToCamelCase(value.toString());
    }
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
}
