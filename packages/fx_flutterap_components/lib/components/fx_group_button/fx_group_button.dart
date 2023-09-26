import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_group_button/options/group_button_options.dart';
import 'package:fx_flutterap_components/components/fx_group_button/utils/controller/controller.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';

import 'fx_group_button_base.dart';

class FxGroupButton extends StatefulWidget {
  final List<Widget> widgetList;

  final List<Function(int)>? onPressedList;

  final List<int>? selectedIndexes;
  final List<int>? disabledIndexes;
  final bool? isRadio;
  final int? maxSelected;
  final int? initialSelectedindex;
  final double? spacing;
  final double? runSpacing;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final Axis? direction;

  const FxGroupButton({
    Key? key,
    required this.widgetList,
    this.onPressedList,
    this.isRadio,
    this.selectedIndexes,
    this.disabledIndexes,
    this.maxSelected,
    this.initialSelectedindex,
    this.spacing,
    this.runSpacing,
    this.selectedColor,
    this.unSelectedColor,
    this.direction,
  }) : super(key: key);

  @override
  State<FxGroupButton> createState() => _FxGroupButtonState();
}

class _FxGroupButtonState extends State<FxGroupButton> {
  GroupButtonController controller = GroupButtonController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = GroupButtonController(
      // selectedIndex: 20,
      selectedIndexes:
          widget.selectedIndexes ?? [widget.initialSelectedindex ?? 0],

      disabledIndexes: widget.disabledIndexes ?? [],
      // onDisablePressed: (i) => print('Button #$i is disabled'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GroupButton(
        controller: controller,
        isRadio: widget.isRadio ?? false,
        options: GroupButtonOptions(
          spacing: InitialDims.space1,
          runSpacing: InitialDims.space1,
          textPadding: EdgeInsets.all(InitialDims.space1),
          buttonWidth: (InitialDims.space10),
          buttonHeight: (InitialDims.space10),
          unselectedColor: widget.unSelectedColor ?? InitialStyle.buttonColor,
          selectedColor:
              widget.selectedColor ?? InitialStyle.secondaryLightColor,
          direction: widget.direction ?? Axis.horizontal,
          borderRadius: BorderRadius.all(Radius.circular(InitialDims.border2)),
        ),
        buttons: List.generate(widget.widgetList.length, (i) => ""),
        maxSelected: widget.maxSelected,
        onSelected: (val, i, selected) {
          widget.onPressedList![i];
        },
        buttonsWidget: widget.widgetList);
  }
}
