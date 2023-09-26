import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_button/fx_button.dart';
import 'package:fx_flutterap_components/components/fx_image/fx_avatar_image.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_v_spacer.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';

import 'package:fx_flutterap_kernel/structure/responsive_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crm_app/controllers/auth_controller.dart';
import '../structure/structure_dims.dart';
import '../structure/structure_styles.dart';

class DrawerStyle extends StatelessWidget {
  AuthController authController = AuthController();

  final Widget drawerItems;
  final String adminPanelTitle;
  final String fullName;

  DrawerStyle({
    Key? key,
    required this.drawerItems,
    required this.adminPanelTitle,
    required this.fullName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
            color: InitialStyle.secondaryDarkColor,
            borderRadius:
                BorderRadius.all(Radius.circular(InitialDims.border3))),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: InitialDims.space2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _introductionCard(context),

                const FxVSpacer(
                  factor: 0.7,
                ),
                //creating list items of drawer
                drawerItems
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _introductionCard(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: authController
          .getUserDetails(), // Replace with your asynchronous data fetching function
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is loading, you can show a loading indicator or return an empty container
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error, you can handle it accordingly
          return Text('Error: ${snapshot.error}');
        } else {
          // Data is ready, build your _introductionCard widget
          final name = snapshot.data?['name'] ?? "Admin";
          final email = snapshot.data?['email'] ?? "admin@gmail.com";
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "packages/fx_flutterap_components/assets/images/logo.png",
                    width: InitialDims.space19,
                    height: InitialDims.space19,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText(
                        "CRM APP",
                        tag: Tag.h3,
                        size: InitialDims.midTitleFontSize,
                        color: InitialStyle.secondaryTextColor,
                        isBold: true,
                      ),
                      FxText(
                        "CRM Sales App",
                        color: InitialStyle.secondaryTextColor,
                        size: InitialDims.smallFontSize,
                      ),
                    ],
                  ),
                  ResponsiveLayot.isComputer(context)
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: InitialStyle.textColor,
                            size: InitialDims.icon2,
                          )),
                ],
              ),
              const FxVSpacer(),
              FxAvatarImage(
                path:
                    "packages/fx_flutterap_components/assets/images/avatar1.png",
                size: InitialDims.space17,
                borderRadius: InitialDims.space17,
              ),
              const FxVSpacer(),
              FxText(
                name,
                color: InitialStyle.secondaryTextColor,
                size: InitialDims.normalFontSize,
              ),
              FxText(
                email,
                color: InitialStyle.secondaryTextColor,
                size: InitialDims.subtitleFontSize,
              ),
              const FxVSpacer(),
              FxButton(
                text: AppLocalizations.of(context)!.edit,
                fillColor: Colors.transparent,
                borderColor: InitialStyle.onSecondaryColor,
                borderRadiusSize: InitialDims.fullBorder,
                size: InitialDims.icon2,
                textColor: InitialStyle.onSecondaryColor,
              ),
              const FxVSpacer(),
            ],
          );
        }
      },
    );
  }
}
