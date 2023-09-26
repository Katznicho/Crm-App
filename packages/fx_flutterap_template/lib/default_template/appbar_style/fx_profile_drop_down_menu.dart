// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_drop_down/fx_drop_down_button.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_h_divider.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_avatar_image.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_svg_icon.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_h_spacer.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:crm_app/blocs/auth/signin_blocs.dart';
import 'package:crm_app/blocs/auth/signin_events.dart';
import 'package:crm_app/utils/constants/app_routes.dart';
import '../structure/structure_dims.dart';
import '../structure/structure_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crm_app/controllers/auth_controller.dart';

class FxprofileDropDownMenu extends StatefulWidget {
  const FxprofileDropDownMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<FxprofileDropDownMenu> createState() => _FxprofileDropDownMenuState();
}

class _FxprofileDropDownMenuState extends State<FxprofileDropDownMenu> {
  AuthController authController = AuthController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _showSignOutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Disallow tapping outside the dialog to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Sign Out'),
              onPressed: () {
                // Sign out the user
                authController.signOut();
                //authBloc.add(si);

                Navigator.pushReplacementNamed(context, AppRoutes.SIGN_IN);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: authController.getUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is loading, you can show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error, you can handle it accordingly
          return Text('Error: ${snapshot.error}');
        } else {
          // Data is ready, extract the user's name
          String name = snapshot.data?['name'] ?? "Admin";

          // Build your menu with the user's name
          List<Widget> menuWidgetList = [
            _dropDownItemstart(
              name,
              AppLocalizations.of(context)!.admin,
              () {},
              "packages/fx_flutterap_components/assets/svgs/profilecircle.svg",
            ),
            _dropDownItems(AppLocalizations.of(context)!.profile, () {},
                "packages/fx_flutterap_components/assets/svgs/profilecircle.svg"),
            _dropDownItems(AppLocalizations.of(context)!.setting, () {},
                "packages/fx_flutterap_components/assets/svgs/Gear.svg"),
            _dropDownItems(AppLocalizations.of(context)!.help, () {},
                "packages/fx_flutterap_components/assets/svgs/Question.svg"),
            _dropDownItemsend(AppLocalizations.of(context)!.logout, () {},
                "packages/fx_flutterap_components/assets/svgs/SignOut.svg"),
          ];

          List<void Function()> menufunctionList = [
            () {},
            () {},
            () {},
            () {},
            () {}
          ];

          return FxDropdownButton(
            num: menuWidgetList.length,
            menuWidgetList: menuWidgetList,
            menufunctionList: menufunctionList,
            buttonWidget: _button(),
            dropdownWidth: InitialDims.space23 * 2,
            dropdownItemsHeight: InitialDims.space15,
          );
        }
      },
    );
  }

  Widget _button() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: InitialStyle.border,
              radius: InitialDims.icon5 * 0.7,
            ),
            FxAvatarImage(
              path:
                  "packages/fx_flutterap_components/assets/images/avatar1.png",
              size: InitialDims.icon3,
            ),
          ],
        ),
        const FxHSpacer(),
        FxSvgIcon(
          "packages/fx_flutterap_components/assets/svgs/down.svg",
          size: InitialDims.icon2,
          color: InitialStyle.textColor,
        )
      ],
    );
  }

  Widget _dropDownItems(String title, void Function() onTap, String iconPath) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: InitialDims.space3, vertical: InitialDims.space2),
        child: Row(
          children: [
            FxSvgIcon(
              iconPath,
              size: InitialDims.icon4,
              color: InitialStyle.icon,
            ),
            FxHSpacer(),
            FxText(
              title,
              color: InitialStyle.textColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDownItemsend(
      String title, void Function() onTap, String iconPath) {
    return InkWell(
      onTap: () {
        _showSignOutConfirmationDialog(context);
      },
      child: Column(
        children: [
          FxHDivider(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: InitialDims.space3, vertical: InitialDims.space2),
            child: Row(
              children: [
                FxSvgIcon(
                  iconPath,
                  size: InitialDims.icon4,
                  color: InitialStyle.icon,
                ),
                FxHSpacer(),
                FxText(
                  title,
                  tag: Tag.h4,
                  isBold: true,
                  color: InitialStyle.icon,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropDownItemstart(
      String name, String title, void Function() onTap, String iconPath) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: InitialDims.space3, vertical: InitialDims.space2),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: InitialStyle.border,
                      radius: InitialDims.icon3,
                    ),
                    FxAvatarImage(
                      path:
                          "packages/fx_flutterap_components/assets/images/avatar1.png",
                      size: InitialDims.icon3,
                    ),
                  ],
                ),
                FxHSpacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText(
                      name,
                      isBold: true,
                      color: InitialStyle.titleTextColor,
                    ),
                    FxText(
                      title,
                      isBold: true,
                      tag: Tag.h5,
                    ),
                  ],
                ),
              ],
            ),
          ),
          FxHDivider(),
        ],
      ),
    );
  }
}
