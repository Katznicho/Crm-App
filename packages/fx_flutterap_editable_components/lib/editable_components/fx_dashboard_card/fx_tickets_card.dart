import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_checkbox/fx_custom_check_box.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_avatar_image.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_svg_icon.dart';
import 'package:fx_flutterap_components/components/fx_label/fx_content_label.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_h_spacer.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_v_spacer.dart';
import 'package:fx_flutterap_components/components/fx_table/fx_simple_table.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_kernel/structure/responsive_layout.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';

// import 'package:crm_app/controllers/FormController.dart';

class FxTicketsCard extends StatefulWidget {
  final List<List<Widget>>? rowContent;

  final List<Map<String, dynamic>>? titleContent;

  const FxTicketsCard({
    Key? key,
    this.rowContent,
    this.titleContent,
  }) : super(key: key);

  @override
  State<FxTicketsCard> createState() => _FxTicketsCardState();
}

List<List<Widget>> _convertRowContent(List<Map<String, dynamic>> contentList) {
  // Convert each map in contentList to a list of widgets and return a list of such lists
  return contentList.map((contentMap) {
    // Create a list of widgets from the contentMap
    List<Widget> rowWidgets = [
      // Create your widgets here based on the contentMap
    ];
    return rowWidgets;
  }).toList();
}

List<Widget> _convertTitleContent(List<Map<String, dynamic>> contentList) {
  // Convert each map in contentList to a widget and return a list of widgets
  return contentList.map((contentMap) {
    // Create your widget here based on the contentMap
    // Widget titleWidget = Text(contentMap['title']);
    Widget titleWidget = Padding(
      padding:
          const EdgeInsets.all(10.0), // here adjust the padding value as needed
      child: FxText(
        contentMap['title'],
        tag: Tag.h4,
        color: InitialStyle.textColor,
        isBold: true,
      ),
    );
    return titleWidget;
  }).toList();
}

class _FxTicketsCardState extends State<FxTicketsCard> {
  @override
  Widget build(BuildContext context) {
    // List<List<Widget>> rowContent0 = _convertRowContent(widget.rowContent ?? []);
    List<List<Widget>> rowContent0 = widget.rowContent ?? [];

    List<Widget> titleContent0 =
        _convertTitleContent(widget.titleContent ?? []);

    return SizedBox(
      height: InitialDims.space25 * 3,
      child: FxSimpleTable(
        rowsContent: rowContent0,
        headingColor: InitialStyle.secondaryDarkColor,
        dataRowHeight: InitialDims.space20,
        columnTitle: titleContent0,
        verticalModeBreakPoint: ResponsiveLayot.tabletLimit,
      ),
    );
  }

  Widget _bioTile(String avatarpath, String name, String description) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FxAvatarImage(path: avatarpath),
        const FxHSpacer(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FxText(
                name,
                tag: Tag.h4,
                color: InitialStyle.titleTextColor,
              ),
              const FxVSpacer(),
              FxText(
                description,
                tag: Tag.h5,
                color: InitialStyle.secondaryTextColor,
                overFlowTag: true,
                align: TextAlign.start,
                maxLine: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _descriptionTile(String description) {
    return FxText(
      description,
      tag: Tag.h4,
      color: InitialStyle.titleTextColor,
      align: TextAlign.start,
    );
  }

  Widget _dateTimeTile(String dateTime) {
    return FxText(
      dateTime,
      tag: Tag.h4,
      color: InitialStyle.textColor,
    );
  }
}
