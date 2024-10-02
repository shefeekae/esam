import 'package:app_filter_form/app_filter_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_config/services/user_auth_services.dart';
import 'package:nectar_assets/core/blocs/theme/theme_bloc.dart';
import 'package:nectar_assets/ui/pages/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:nectar_assets/ui/pages/forgot%20password/forgot_password_screen.dart';
import 'package:nectar_assets/ui/pages/login/widgets/custom_textfield.dart';
import 'package:nectar_assets/ui/shared/widgets/logo/logo_widget.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../core/services/notifications/notification_services.dart';
import '../../shared/widgets/custom_snackbar.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static const String id = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool checked = true;

  bool obscure = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late ThemeBloc themeBloc;

  @override
  void initState() {
    themeBloc = BlocProvider.of<ThemeBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LogoWidget(
                        height: 12.h,
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      BuildTextformField(
                        hintText: "Username",
                        controller: usernameController,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      BuildTextformField(
                        hintText: "Password",
                        controller: passwordController,
                        enableObscure: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      buildRememberMe(),
                      SizedBox(
                        height: 30.sp,
                      ),
                      buildLoginButton(context),
                      SizedBox(
                        height: 5.sp,
                      ),
                      CupertinoButton(
                        child: const Text("Forgot Password?"),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ForgotPasswordScreen.id);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================================================================================
  Widget buildRememberMe() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          children: [
            Checkbox(
              value: checked,
              checkColor: Colors.white,
              onChanged: (value) {
                setState(
                  () {
                    checked = value!;
                  },
                );
              },
            ),
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    checked = !checked;
                  },
                );
              },
              child: const Text(
                "Remember me",
              ),
            )
          ],
        );
      },
    );
  }

  // ===================================================================
  Widget buildLoginButton(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 15.sp,
      color: kWhite,
      fontWeight: FontWeight.w700,
    );

    String loginLabel = "Login";

    return StatefulBuilder(
      builder: (context, setState) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () async {
          bool isValid = _formKey.currentState!.validate();

          if (isValid) {
            setState(
              () {
                loginLabel = "Loading...";
              },
            );

            UserAuthServices()
                .loginUser(
              username: usernameController.text.trim(),
              password: passwordController.text.trim(),
            ).then((value) {
              // print("Result $value");
              if (value.isEmpty) {
                NotificationServiceHelper()
                    .firebaseMessagingSubcribeOrUnsubcribeTopic(subcribe: true);

                StorageServices().storeRememberMe(checked);

                themeBloc.add(UpdateTheme());

                Navigator.of(context)
                    .pushReplacementNamed(BottomNavBarScreen.id);
                return;
              } else if (value == "Request is incomplete") {
                buildSnackBar(
                  context: context,
                  value: "Username or Password is incorrect",
                );
              } else {
                buildSnackBar(
                  context: context,
                  value: value,
                );
              }
              setState(() {
                loginLabel = "Log In";
              });
            });
          }
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: Text(
            loginLabel,
            style: style,
            key: ValueKey(loginLabel),
          ),
        ),
      ),
    );
  }
}
