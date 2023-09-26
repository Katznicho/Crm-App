import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';

import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:flutter/material.dart';

import 'fx_drop_down.dart';

class FxDropDownForm extends FormField<String> {
  FxDropDownForm({
    Key? key,
    String? initialTitle,
    required List list,
    String idName = "_id",
    String valueName = "title",
    FormFieldSetter<String>? onSaved,
    required FormFieldValidator<String> validator,
    String initialValue = "",
    required String value,
    ValueChanged<String>? onSelect,
    Widget? buttonWidget,
    Offset? menuOffset,
    BoxDecoration? dropdownDecoration,
    double? dropdownWidth,
    double? dropdownItemsHeight,
    EdgeInsetsGeometry? buttonPadding,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<String> state) {
              return FxDropDown(
                buttonWidget: buttonWidget,
                menuOffset: menuOffset,
                dropdownDecoration: dropdownDecoration,
                dropdownWidth: dropdownWidth,
                dropdownItemsHeight: dropdownItemsHeight,
                initialTitle: initialTitle ?? "انتخاب کنید:",
                value: state.value ?? "",
                // value: state.value??value,
                onChanged: state.didChange,
                subTitleWidget: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => FxText(
                            state.errorText.toString(),
                            color: InitialStyle.dangerColorRegular),
                      )
                    : null,
                list: list,
              );
            });
}
