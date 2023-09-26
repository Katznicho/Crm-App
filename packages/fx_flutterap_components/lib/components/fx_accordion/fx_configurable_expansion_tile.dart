import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_svg_icon.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';

class FxConfigurableExpansionTile extends StatefulWidget {
  final Icon? icon;
  final Icon? openIcon;
  final Icon? closeIcon;
  final Decoration? decoration;
  final EdgeInsetsGeometry? tilePadding;
  final EdgeInsetsGeometry? childrenPadding;
  final Widget title;
  final List<Widget> children;
  final EdgeInsetsGeometry? margin;
  final String? backGroundImagePath;
  final Color? iconColor;
  final Color? textColor;
  final Color? collapsedIconColor;
  final Color? collapsedTextColor;
  final bool? initialyExpanded;
  final void Function(bool)? onExpansionChanged;

  const FxConfigurableExpansionTile(
      {Key? key,
      this.icon,
      this.openIcon,
      this.closeIcon,
      this.decoration,
      this.tilePadding,
      this.childrenPadding,
      required this.title,
      required this.children,
      this.margin,
      this.backGroundImagePath,
      this.iconColor,
      this.initialyExpanded,
      this.onExpansionChanged,
      this.textColor,
      this.collapsedIconColor,
      this.collapsedTextColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FxConfigurableExpansionTileState();
  }
}

class _FxConfigurableExpansionTileState
    extends State<FxConfigurableExpansionTile> {
  bool isExpanded = false;

  // Generate a list of list items
  // In real app, data often is fetched from an API or a database

  // This function is called when a "Remove" button associated with an item is pressed

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isExpanded = widget.initialyExpanded ?? false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header = Flexible(
        child: Container(
      padding: widget.tilePadding ??
          EdgeInsets.symmetric(
              vertical: InitialDims.space1, horizontal: InitialDims.space2),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.title,
          isExpanded
              ? widget.closeIcon ??
                  FxSvgIcon(
                    "packages/fx_flutterap_components/assets/svgs/up.svg",
                    size: InitialDims.icon2,
                    color: widget.iconColor ?? InitialStyle.primaryDarkColor,
                  )
              : widget.openIcon ??
                  FxSvgIcon(
                    "packages/fx_flutterap_components/assets/svgs/down.svg",
                    size: InitialDims.icon2,
                    color: widget.iconColor ?? InitialStyle.primaryDarkColor,
                  ),
        ],
      ),
    ));
    List<Widget> children = List.generate(
        widget.children.length,
        (index) => Container(
              padding: widget.childrenPadding ??
                  EdgeInsets.symmetric(
                      vertical: InitialDims.space2,
                      horizontal: InitialDims.space2),
              child: widget.children[index],
            ));
    return Container(
      // this key is required to save and restore ExpansionTile expanded state

      margin:
          widget.margin ?? EdgeInsets.symmetric(vertical: InitialDims.space2),
      decoration: widget.decoration ?? const BoxDecoration(),
      child: Stack(
        children: [
          if (widget.backGroundImagePath == null)
            Container()
          else
            Positioned.fill(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: widget.decoration ??
                    const BoxDecoration(
                        // color: InitialStyle.primaryColor,
                        // borderRadius: BorderRadius.all(Radius.circular(InitialDims.space5))
                        ),
                child: Image.asset(
                  widget.backGroundImagePath ?? "",
                  // color: InitialStyle.primaryDarkColor,
                  // colorBlendMode:BlendMode.multiply,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ConfigurableExpansionTile(
              header: header,
              initiallyExpanded: widget.initialyExpanded ?? false,
              onExpansionChanged: (bool expanded) {
                setState(() {
                  isExpanded = expanded;
                });
                widget.onExpansionChanged!(expanded);
              },
              childrenBody: Column(
                children: children,
              )),
        ],
      ),
    );
  }
}
