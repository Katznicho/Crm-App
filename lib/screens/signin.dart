import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fx_flutterap_components/components/fx_button/fx_block_button.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_text_field/fx_text_field_form.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_v_spacer.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import '../screens/components/global_widgets/fx_authentication_frame.dart';
import '../blocs/auth/signin_events.dart';
import '../utils/utilities.dart';
import '../blocs/auth/signin_blocs.dart';
import '../blocs/auth/signin_states.dart';
import '../utils/constants/app_routes.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_config.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String? _username;
  String? _password;

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isLoadingButton = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    InitialStyle(context);
    InitialDims(context);
    InitialConfig();
    return BlocListener<AuthBloc, AuthStates>(
      listener: (context, state) {
        if (state is SignInLoading) {
          setState(() {
            _isLoading = true;
          });
        }

        if (state is SignInSuccess) {
          _username = null;
          _password = null;
          // _isLoading = false;
          Navigator.pushNamed(context, AppRoutes.HOME);
          Utils().showSnackBar(context, "Welcom Back to CRM Sales App");
        }

        if (state is SignInFailure) {
          Utils().showSnackBar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<AuthBloc, AuthStates>(
        builder: (context, state) {
          return FxAuthenticationFrame(
            imagePath: "assets/images/illustaration3.png",
            formContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FxVSpacer(
                  big: true,
                  factor: 5,
                ),
                FxText(
                  "CRM Management Login",
                  tag: Tag.h3,
                  color: InitialStyle.titleTextColor,
                  align: TextAlign.start,
                  isBold: true,
                ),
                const FxVSpacer(
                  big: true,
                  factor: 2,
                ),
                FxText(
                  "Welcom Back to CRM Sales App",
                  color: InitialStyle.secondaryTextColor,
                ),
                const FxVSpacer(
                  big: true,
                  factor: 5,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FxTextFieldForm(
                        hint: AppLocalizations.of(context)!.usernamehint,
                        label: AppLocalizations.of(context)!.username,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.usernamehint;
                          }
                          return null;
                        },
                        onChanged: (username) {
                          _username = username;
                        },
                        prefixIcon: Icon(
                          Icons.person,
                          color: InitialStyle.icon,
                        ),
                      ),
                      const FxVSpacer(
                        big: true,
                        factor: 2,
                      ),
                      FxTextFieldForm(
                        isObscure: !_isPasswordVisible,
                        hint: AppLocalizations.of(context)!.passwordhint,
                        label: AppLocalizations.of(context)!.password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.passwordhint;
                          }
                          return null;
                        },
                        onChanged: (password) {
                          _password = password;
                        },
                        prefixIcon: Icon(
                          Icons.key,
                          color: InitialStyle.icon,
                        ),
                        suffixIcon: IconButton(
                          onPressed:
                              _togglePasswordVisibility, // Call the toggle function
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: InitialStyle.icon,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const FxVSpacer(
                  big: true,
                  factor: 2,
                ),
                Column(
                  children: [
                    FxBlockButton(
                      text: _isLoadingButton
                          ? ""
                          : AppLocalizations.of(context)!.login,
                      onTap: () async {
                        if (!_isLoadingButton) {
                          setState(() {
                            _isLoading = true;
                            _isLoadingButton = true;
                            // const CircularProgressIndicator();
                          });
                        }

                        if (_formKey.currentState?.validate() == true) {
                          try {
                            BlocProvider.of<AuthBloc>(context).add(SignInEvent(
                              username: _username!,
                              password: _password!,
                            ));
                          } catch (error) {}

                          setState(() {
                            _isLoadingButton = false;
                            _isLoading = false;
                          });
                        } else {
                          setState(() {
                            _isLoadingButton = false;
                            _isLoading = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    if (_isLoading) const CircularProgressIndicator(),
                    // const SizedBox(height: 10),
                  ],
                ),
                const FxVSpacer(
                  big: true,
                  factor: 2,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      runSpacing: InitialDims.space2,
                      spacing: InitialDims.space2,
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.pop(context);
                            Navigator.pushNamed(context, AppRoutes.SIGN_IN);
                          },
                          child: FxText(
                            AppLocalizations.of(context)!.forgetthepassword,
                            isBold: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const FxVSpacer(
                  big: true,
                  factor: 2,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FxText(
                      AppLocalizations.of(context)!.donothaveanaccount,
                      isBold: true,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.SIGN_IN);
                      },
                      child: FxText(
                        AppLocalizations.of(context)!.create,
                        // color: InitialStyle.secondaryDarkColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
