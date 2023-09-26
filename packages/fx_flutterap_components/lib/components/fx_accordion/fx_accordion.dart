import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_svg_icon.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_h_spacer.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';

import 'package:fx_flutterap_kernel/structure/global_variables.dart';

class FxAccordion extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final Widget? icon;
  final Widget? openIcon;
  final Widget? closeIcon;
  final Decoration? decoration;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? childrenPadding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? titleTextStyle;
  final TextStyle? childrenTextStyle;
  final bool isRemovable;
  final Widget? removeIcon;
  final String? backGroundImagePath;
  final Color? contentColor;

  const FxAccordion(
      {required this.items,
      this.icon,
      this.openIcon,
      this.closeIcon,
      this.decoration,
      this.titlePadding,
      this.childrenPadding,
      this.margin,
      this.titleTextStyle,
      this.childrenTextStyle,
      this.isRemovable = false,
      this.removeIcon,
      this.backGroundImagePath,
      this.contentColor,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FxAccordionState();
  }
}

class _FxAccordionState extends State<FxAccordion> {
  // Generate a list of list items
  // In real app, data often is fetched from an API or a database

  // This function is called when a "Remove" button associated with an item is pressed
  void _removeItem(int id) {
    setState(() {
      widget.items.removeWhere((element) => element['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 600),
        content: Text('Item with id #$id has been removed')));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isExpanded = List.generate(widget.items.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.items.length, (index) {
        final item = widget.items[index];
        return Container(
          // this key is required to save and restore ExpansionTile expanded state
          key: PageStorageKey(item['id']),
          margin: widget.margin ??
              EdgeInsets.symmetric(vertical: InitialDims.space2),
          decoration: widget.decoration ??
              const BoxDecoration(
                  // color: InitialStyle.primaryColor,
                  // borderRadius: BorderRadius.all(Radius.circular(InitialDims.space5))
                  ),
          child: Stack(
            children: [
              widget.backGroundImagePath == null
                  ? Container()
                  : Positioned.fill(
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: widget.decoration ??
                            const BoxDecoration(
                                // color: InitialStyle.primaryColor,
                                // borderRadius: BorderRadius.all(Radius.circular(InitialDims.space5))
                                ),
                        child: Image.asset(
                          widget.backGroundImagePath ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              ExpansionTile(
                // controlAffinity: ListTileControlAffinity.leading,
                textColor: widget.contentColor ?? InitialStyle.textColor,
                collapsedTextColor:
                    widget.contentColor ?? InitialStyle.textColor,
                collapsedIconColor:
                    widget.contentColor ?? InitialStyle.textColor,

                trailing: isExpanded[index]
                    ? widget.closeIcon ??
                        FxSvgIcon(
                          "packages/fx_flutterap_components/assets/svgs/up.svg",
                          size: InitialDims.icon3,
                          color: widget.contentColor ?? InitialStyle.icon,
                        )
                    : widget.openIcon ??
                        FxSvgIcon(
                          "packages/fx_flutterap_components/assets/svgs/down.svg",
                          size: InitialDims.icon3,
                          color: widget.contentColor ?? InitialStyle.icon,
                        ),
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    isExpanded[index] = expanded;
                  });
                },
                iconColor: widget.contentColor ?? InitialStyle.textColor,
                tilePadding: widget.titlePadding ??
                    EdgeInsets.symmetric(horizontal: InitialDims.space5),

                childrenPadding: widget.childrenPadding ??
                    EdgeInsets.symmetric(
                        vertical: InitialDims.space5,
                        horizontal: InitialDims.space5),
                expandedCrossAxisAlignment: CrossAxisAlignment.end,

                maintainState: true,
                title: Row(
                  children: [
                    widget.icon ?? Container(),
                    widget.icon == null ? Container() : const FxHSpacer(),
                    Text(
                      item['title'],
                      style: widget.titleTextStyle ??
                          TextStyle(
                            color:
                                widget.contentColor ?? InitialStyle.textColor,
                          ),
                    ),
                  ],
                ),
                // contents
                children: [
                  Text(
                    item['content'],
                    style: widget.childrenTextStyle ??
                        TextStyle(
                          color: widget.contentColor ?? InitialStyle.textColor,
                        ),
                    textAlign: TextAlign.justify,
                  ),

                  // This button is used to remove this item
                  widget.isRemovable
                      ? InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(top: InitialDims.space2),
                            child: widget.removeIcon ??
                                Icon(
                                  Icons.delete,
                                  color: InitialStyle.dangerColorRegular,
                                ),
                          ),
                          onTap: () {
                            _removeItem(item['id']);
                          },
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
