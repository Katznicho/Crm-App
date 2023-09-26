import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_svg_icon.dart';

import 'package:fx_flutterap_components/components/fx_spacer/fx_h_spacer.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_template/default_template/components/fx_card_decoration.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:fx_flutterap_template/default_template/components/fx_item_indicator_icon.dart';




class FxStatisticCard1 extends StatefulWidget {
  final String? imagePath;
  final String? label;
  final String? displayText;
  final String? number;

  final Widget? customContent; // Make customContent optional

  const FxStatisticCard1({
    Key? key,
    this.imagePath,
    this.label,
    this.displayText,
    this.number,
    this.customContent, // Add customContent as an optional parameter
  }) : super(key: key);

  @override
  State<FxStatisticCard1> createState() => _FxStatisticCard1State();
}

class _FxStatisticCard1State extends State<FxStatisticCard1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: FxCardDecoration().decoration,
      child: Padding(
        padding: EdgeInsets.all(InitialDims.space5),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Adjusted to start from left
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wrap in column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FxHSpacer(
                      big: true,
                    ),
                    
                     FxText(
                      widget.label ?? "Total income",
                      color: InitialStyle.titleTextColor,
                      isBold: true,
                      align: TextAlign.justify,
                      tag: Tag.h3,
                      decoration: TextDecoration.underline,
                      maxLine: 15,
                      size: 14,
                    ),

                     FxText(
                      widget.displayText ?? "lorem ipsum lorem ipsum",
                      color: InitialStyle.textColor,
                      align: TextAlign.justify,
                      tag: Tag.h4,
                      maxLine: 15,
                      size: 14,
                    ),

                    FxText(
                      widget.number ?? "Total income",
                      color: InitialStyle.textColor,
                      // isBold: true,
                      align: TextAlign.justify,
                      tag: Tag.h4,
                      // decoration: TextDecoration.underline,
                      maxLine: 15,
                      size: 14,
                    ),
                   
                    //  Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                        // FxText(
                        //   "Prefix",
                        //   tag: Tag.h5,
                        //   color: prefix ?? true
                        //       ? InitialStyle.successColorRegular
                        //       : InitialStyle.dangerColorRegular,
                        //   align: TextAlign.justify,
                        // ),
                        // prefix ?? true
                        //     ? FxSvgIcon(
                        //         "packages/fx_flutterap_components/assets/svgs/Check.svg",
                        //         size: InitialDims.icon2,
                        //         color: InitialStyle.successColorRegular,
                        //       )
                        //     : FxSvgIcon(
                        //         "packages/fx_flutterap_components/assets/svgs/cross.svg",
                        //         size: InitialDims.icon2,
                        //         color: InitialStyle.dangerColorRegular,
                        //       ),
                        // FxText(
                        //   "Show In Menu",
                        //   tag: Tag.h5,
                        //   color: showInMenu ?? true
                        //       ? InitialStyle.successColorRegular
                        //       : InitialStyle.dangerColorRegular,
                        //   align: TextAlign.justify,
                        // ),
                        // showInMenu ?? true
                        //     ? FxSvgIcon(
                        //         "packages/fx_flutterap_components/assets/svgs/Check.svg",
                        //         size: InitialDims.icon2,
                        //         color: InitialStyle.successColorRegular,
                        //       )
                        //     : FxSvgIcon(
                        //         "packages/fx_flutterap_components/assets/svgs/cross.svg",
                        //         size: InitialDims.icon2,
                        //         color: InitialStyle.dangerColorRegular,
                        //       ),
                        // FxText(
                        //   "Taggable",
                        //   tag: Tag.h5,
                        //   color: taggable ?? true
                        //       ? InitialStyle.successColorRegular
                        //       : InitialStyle.dangerColorRegular,
                        //   align: TextAlign.justify,
                        // ),
                        // taggable ?? true
                        //     ? FxSvgIcon(
                        //         "packages/fx_flutterap_components/assets/svgs/Check.svg",
                        //         size: InitialDims.icon2,
                        //         color: InitialStyle.successColorRegular,
                        //       )
                        //     : FxSvgIcon(
                        //         "packages/fx_flutterap_components/assets/svgs/cross.svg",
                        //         size: InitialDims.icon2,
                        //         color: InitialStyle.dangerColorRegular,
                        //       ),
                    //   ],
                    // ),
                  ],
                ),
                const FxHSpacer(),
                const Spacer(),
                FxItemIndicatorIcon(
                  iconPath: widget.imagePath ??
                      "packages/fx_flutterap_components/assets/svgs/Pencil.svg",
                ),
              ],
            ),
            const SizedBox(height: 16), // Add spacing
            widget.customContent ?? SizedBox(), // Display customContent if provided
          ],
        ),
      ),
    );
  }
}
