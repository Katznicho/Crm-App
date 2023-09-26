// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_checkbox/fx_custom_check_box.dart';

import 'package:fx_flutterap_components/components/fx_image/fx_avatar_image.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_avatar_widget.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_svg_icon.dart';
import 'package:fx_flutterap_components/components/fx_label/fx_content_label.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_h_spacer.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_v_spacer.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_components/local/packages/flutter_datetime_picker/src/date_format.dart';
import 'package:fx_flutterap_editable_components/editable_components/fx_dashboard_card/fx_generated_leads_chart.dart';
import 'package:fx_flutterap_editable_components/editable_components/fx_dashboard_card/fx_new_users.dart';

import 'package:fx_flutterap_editable_components/editable_components/fx_dashboard_card/fx_tickets_card.dart';

import 'package:fx_flutterap_kernel/structure/responsive_layout.dart';
import 'package:fx_flutterap_template/default_template/components/fx_card_decoration.dart';
import 'package:fx_flutterap_template/default_template/components/fx_container_items.dart';
import 'package:fx_flutterap_template/default_template/components/fx_page_header.dart';
import 'package:fx_flutterap_template/default_template/components/fx_page_title_container.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_config.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:fx_flutterap_editable_components/editable_components/fx_dashboard_card/fx_statistic_card_1.dart';
import 'package:fx_flutterap_editable_components/editable_components/fx_dashboard_card/fx_statistic_card_2.dart';

class FcDashboard extends StatefulWidget {
  // static const routeName = '/fc-dashboard';
  final Map<String, dynamic>? collectionData;

  const FcDashboard({Key? key, this.collectionData}) : super(key: key);

  @override
  State<FcDashboard> createState() => _FcDashboardState();
}

class _FcDashboardState extends State<FcDashboard> {
  @override
  void initState() {
    super.initState();
  }

  BootstrapCol cardShow2(BuildContext context, Widget widget) {
    return BootstrapCol(
      sizes: 'col-sm-12 col-ml-6 col-lg-6 col-xl-3',
      child:
          Container(margin: FxCardDecoration().cardShowMargin, child: widget),
    );
  }

  BootstrapCol cardShow4(Widget widget) {
    return BootstrapCol(
        sizes: 'col-sm-12 col-ml-12 col-lg-4 col-xl-4',
        child: Container(
            margin: FxCardDecoration().cardShowMargin, child: widget));
  }

  Widget buildFxStatisticCards(List<Map<String, dynamic>> formData) {
    final cardMargin =
        EdgeInsets.only(top: FxCardDecoration().cardShowMargin.vertical);

    return SizedBox(
      height: 4 * (InitialDims.space20 + cardMargin.top),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: formData.map((data) {
            String collectionName = data['collectionName'] ?? 'Total income';

            // Get the available width for the card
            double availableWidth =
                MediaQuery.of(context).size.width - cardMargin.horizontal;

            // Calculate the maximum number of characters that can fit within the available width
            int maxChars = (availableWidth / 12)
                .floor(); // Adjust the divisor as needed for your font size

            // Trim the collectionName string based on the available width
            if (collectionName.length > maxChars) {
              collectionName = '${collectionName.substring(0, maxChars)}...';
            }

            return InkWell(
              child: cardShow2(
                context,
                FxStatisticCard1(
                  imagePath:
                      "packages/fx_flutterap_components/assets/svgs/right.svg",
                  number: collectionName,
                  displayText:
                      data['collectionType'] ?? 'lorem ipsum lorem ipsum',
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double factor = (ResponsiveLayot.isPhone(context)) ? 0.7 : 1;

    List<String> messageList = List.generate(
      6,
      (index) => AppLocalizations.of(context)!.lorem,
    );

    List<Widget> indicatorList = [
      FxAvatarImage(
        path: "packages/fx_flutterap_components/assets/images/avatar1.png",
        borderRadius: InitialDims.space5,
      ),
      FxAvatarWidget(
          backGroundColor: InitialStyle.specificColor,
          widget: FxText(
            "L",
            tag: Tag.h3,
            color: InitialStyle.primaryLightColor,
          )),
      FxAvatarWidget(
          backGroundColor: InitialStyle.primaryLightColor,
          widget: FxSvgIcon(
            "packages/fx_flutterap_components/assets/svgs/gallery.svg",
            size: InitialDims.icon3,
            color: InitialStyle.primaryDarkColor,
          )),
      FxAvatarImage(
        path: "packages/fx_flutterap_components/assets/images/avatar4.png",
        borderRadius: InitialDims.space5,
      ),
    ];

    Widget content1() {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: InitialDims.space1,
          horizontal: InitialDims.space1,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxText(
                AppLocalizations.of(context)!.loremshort,
                tag: Tag.h3,
                size: InitialDims.normalFontSize,
                color: InitialStyle.titleTextColor,
                align: TextAlign.start,
              ),
              const FxVSpacer(
                factor: 0.5,
              ),
              FxText(
                AppLocalizations.of(context)!.lorem,
                align: TextAlign.justify,
                color: InitialStyle.textColor,
                size: InitialDims.subtitleFontSize,
                overFlowTag: true,
                maxLine: 1,
              ),
              const FxVSpacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: InitialDims.icon2,
                    color: InitialStyle.secondaryTextColor,
                  ),
                  const FxHSpacer(),
                  FxText(
                    "",
                    tag: Tag.h5,
                    color: InitialStyle.secondaryTextColor,
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget content2() {
      double imageSize = (InitialDims.space13 * factor);
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: InitialDims.space1,
          horizontal: InitialDims.space1,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: InitialDims.space1,
                runSpacing: InitialDims.space1,
                children: [
                  Image.asset(
                    "packages/fx_flutterap_components/assets/images/img1.png",
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                  const FxHSpacer(),
                  Image.asset(
                    "packages/fx_flutterap_components/assets/images/img2.png",
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                  const FxHSpacer(),
                  Image.asset(
                    "packages/fx_flutterap_components/assets/images/img3.png",
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const FxVSpacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: InitialDims.icon2,
                    color: InitialStyle.secondaryTextColor,
                  ),
                  const FxHSpacer(),
                  FxText(
                    "",
                    tag: Tag.h5,
                    color: InitialStyle.secondaryTextColor,
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget dashboardContainerItems({
      required String title,
      required Widget child,
      EdgeInsetsGeometry? widgetPadding,
    }) {
      return FxContainerItems(
        title: title,
        margin: EdgeInsets.all(InitialDims.space0),
        widgetPadding: widgetPadding,
        child: child,
      );
    }

    BootstrapCol cardShow1(Widget widget) {
      return BootstrapCol(
          sizes: 'col-sm-12 col-ml-12 col-lg-12 col-xl-12',
          child: Container(
              margin: FxCardDecoration().cardShowMargin, child: widget));
    }

    BootstrapCol cardShow3(Widget widget) {
      return BootstrapCol(
          sizes: 'col-sm-6 col-ml-3 col-lg-3 col-xl-2',
          child: Container(
              margin: FxCardDecoration().cardShowMargin, child: widget));
    }

    BootstrapCol cardShow5(Widget widget) {
      return BootstrapCol(
          sizes: 'col-sm-12 col-ml-12 col-lg-6 col-xl-6',
          child: Container(
              margin: FxCardDecoration().cardShowMargin, child: widget));
    }

    List list = [
      BootstrapContainer(
        fluid: true,
        children: [
          BootstrapRow(
            children: [
              cardShow3(FxStatisticCard2(
                imagePath:
                    "packages/fx_flutterap_components/assets/svgs/profilecircle.svg",
                number: "20",
                description: "Generated Leads",
                hasGrown: false,
              )),
              cardShow3(FxStatisticCard2(
                imagePath:
                    "packages/fx_flutterap_components/assets/svgs/shoppingcart.svg",
                number: "5",
                description: "Orders",
              )),
              cardShow3(FxStatisticCard2(
                imagePath:
                    "packages/fx_flutterap_components/assets/svgs/dollarsquare.svg",
                number: "313K",
                // changePercent: "17%",
                description: "Generated Income",
                hasGrown: false,
              )),
              cardShow3(FxStatisticCard2(
                imagePath:
                    "packages/fx_flutterap_components/assets/svgs/favoritechart.svg",
                number: "400",
                // changePercent: "4.98%",
                description: "Engagements",
              )),
              cardShow4(
                FxGeneratedLeadsChart(),
              ),
            ],
          ),
        ],
      ),
    ];

    bootstrapGridParameters(gutterSize: InitialDims.space0);
    return Material(
        color: InitialStyle.background,
        child: Scaffold(
          backgroundColor: InitialStyle.background,
          body: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      FxPageHeader(
                        title: "CRM SALES DASHBOARD",
                      ),
                      FxPageTitleContainer(
                        information: "Hello James",
                        description: "Your Dashboard Today",
                      ),
                    ],
                  ),
                  BootstrapContainer(
                      fluid: true,
                      padding: EdgeInsets.all(InitialDims.space3),
                      decoration: BoxDecoration(
                        color: InitialStyle.background,
                      ),
                      children: List.generate(
                          list.length, (index) => _boxShow(list[index])))
                ],
              ),
            ),
          ),
        ));
  }

  Widget _boxShow(Widget widget) {
    return BootstrapCol(
        sizes: 'col-sm-12 col-ml-12 col-lg-12 col-xl-12', child: widget);
  }
}



// FutureBuilder<List<dynamic>>(
//                   future: FormController().fetchAndGenerateCollections(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return Text('No data available');
//                     } else {
//                       // Use the data from the backend to build your cards dynamically.
//                       List? cards = snapshot.data;
//                       for (var card in cards!) {
//                         // list.add(
//                         //   cardShow3(FxStatisticCard2(
//                         //     imagePath:
//                         //         "packages/fx_flutterap_components/assets/svgs/profilecircle.svg",
//                         //     number: "20",
//                         //     description: "Generated Leads",
//                         //     hasGrown: false,
//                         //   )),
//                         // );
//                       }

//                       return BootstrapContainer(
//                           fluid: true,
//                           padding: EdgeInsets.all(InitialDims.space3),
//                           decoration: BoxDecoration(
//                             color: InitialStyle.background,
//                           ),
//                           children: List.generate(
//                               list.length, (index) => _boxShow(list[index])));
//                     }
//                   },
//                 ),