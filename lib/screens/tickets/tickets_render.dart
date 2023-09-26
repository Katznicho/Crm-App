import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_button/fx_block_button.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_svg_icon.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_h_divider.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_v_spacer.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_template/default_template/components/fx_card_header.dart';
import 'package:fx_flutterap_template/default_template/components/fx_page_header.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';

import '../../utils/utilities.dart';

class TicketRenderer extends StatefulWidget {
  final List<dynamic> data;
  final String title;
  const TicketRenderer({super.key, required this.data, required this.title});

  @override
  State<TicketRenderer> createState() => _TicketRendererState();
}

class _TicketRendererState extends State<TicketRenderer> {
  late final String title;
  TextEditingController searchController = TextEditingController();
  int itemsPerPage = 20; // Number of items to show per page
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    title = widget.title;
  }

  void _filterData(String query) {
    setState(() {
      currentPage = 0;
    });
  }

  List<dynamic> getPaginatedData() {
    // Calculate the start and end indices for the current page
    final startIndex = currentPage * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    // Return a sublist of data for the current page
    if (widget.data != null) {
      return widget.data!
          .sublist(startIndex, endIndex.clamp(0, widget.data!.length));
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = getPaginatedData();
    // Calculate the total number of pages
    final totalPages = (widget.data!.length / itemsPerPage).ceil();

    return Material(
      color: InitialStyle.background,
      child: Scaffold(
        backgroundColor: InitialStyle.background,
        appBar: AppBar(
          title: FxPageHeader(title: title),
          automaticallyImplyLeading: false,
          backgroundColor: InitialStyle.background,
          actions: [
            IconButton(
              icon: FxSvgIcon(
                "packages/fx_flutterap_components/assets/svgs/search.svg",
                color: InitialStyle.icon,
                size: InitialDims.icon5,
              ),
              onPressed: () {},
            ),
            PopupMenuButton<int>(
              icon: const Icon(
                Icons.view_list, // Icon for selecting items per page
                color: Colors.black,
              ),
              onSelected: (int value) {
                setState(() {
                  itemsPerPage = value;
                  currentPage =
                      0; // Reset to the first page when changing items per page
                });
              },
              itemBuilder: (BuildContext context) {
                final availableOptions = [
                  10,
                  20,
                  30,
                  50,
                  100
                ]; // Default options
                return availableOptions.map((option) {
                  return PopupMenuItem<int>(
                    value: option,
                    child: FxText('Show $option $title per page'),
                  );
                }).toList();
              },
            ),
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert, // Replace with the ellipsis icon you want
                color: Colors.black,
              ),
              onSelected: (value) {
                // Handle menu item selection here
                if (value == 'create') {
                  // Navigate to the screen for creating a new item
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) =>
                  //       DetScreen(), // Replace with your screen for creating items
                  // ));
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'filter',
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      FxText(
                        'Filter',
                        isBold: true,
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'sort',
                  child: Row(
                    children: [
                      Icon(
                        Icons.sort,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      FxText(
                        'Sort',
                        isBold: true,
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'create',
                  child: Row(
                    children: [
                      Icon(
                        Icons
                            .add_circle_outline, // Replace with the ellipsis icon you want
                        color: Colors
                            .blue, // Change the color of the ellipsis icon
                      ),
                      SizedBox(width: 10), // Add spacing between icon and text
                      FxText(
                        'Create New Item',
                        isBold: true,
                      ),
                    ],
                  ),
                ),
                // Add more menu items as needed
              ],
            ),
          ],
        ),
        body: Container(
          color: InitialStyle.background,
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final item = filteredData[index];

              return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(InitialDims.space2),
                    padding: EdgeInsets.symmetric(
                      vertical: InitialDims.space5,
                    ),
                    decoration: BoxDecoration(
                      color: InitialStyle.cardColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular((InitialDims.border3))),
                      boxShadow: [
                        BoxShadow(
                            color: InitialStyle.shadow,
                            blurRadius: InitialDims.space5),
                      ],
                    ),
                    child: ListTile(
                        title: Utils().cardShow(
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
                              // Navigator.of(context).push(
                              //   // MaterialPageRoute(builder: (context) => {}),
                              // );
                            },
                          ),
                        ],
                      ),
                    )),
                  ));
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: InitialStyle.cardColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    if (currentPage > 0) {
                      currentPage--;
                    }
                  });
                },
              ),
              FxText('Page ${currentPage + 1}/$totalPages'),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    if ((currentPage + 1) * itemsPerPage <
                        widget.data!.length) {
                      currentPage++;
                    }
                  });
                },
              ),
            ],
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
      if (entry.value == null) {
        continue;
      }

      widgets.add(
        Container(
            padding: EdgeInsets.symmetric(
              vertical: InitialDims.space2,
            ),
            child: Utils().cardShow(
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
                                title: Utils().convertToCamelCase(entry.key),
                                information: count == 0
                                    ? null
                                    : Utils().convertToCamelCase(
                                        _buildValueWidget(entry.value)
                                            .toString()),
                                isBold: false),
                            if (count == 0)
                              FxCardHeader(
                                title: (Utils().convertToCamelCase(
                                    _buildValueWidget(entry.value,
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
                  // if (count < 4)
                  const FxVSpacer(),
                  if (count < 3) const FxHDivider(),
                ],
              ),
            )),
      );

      count++;
      if (count >= 4) {
        break; // Limit to the first 3 key-value pairs
      }
    }

    return Utils().cardShow(Column(
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
        return Utils().convertToCamelCase(trimmedValue);
      } else {
        return Utils()
            .convertToCamelCase("${trimmedValue.substring(0, trimValue)}...");
      }
    } else if (value is int) {
      return Utils().convertToCamelCase(value.toString());
    } else if (value is double) {
      return Utils().convertToCamelCase(value.toString());
    } else if (value is bool) {
      return Utils().convertToCamelCase(value.toString());
    } else {
      return Utils().convertToCamelCase(value.toString());
    }
  }
}
