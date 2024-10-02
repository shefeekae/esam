import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:graphql_config/widget/mutation_widget.dart';
import 'package:nectar_assets/core/schemas/user_schemas.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_elevated_button.dart';
import 'package:nectar_assets/ui/shared/widgets/custom_snackbar.dart';
import 'package:nectar_assets/ui/shared/widgets/logo/logo_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../login/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  static const String id = '/forgotpassword';

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        hintText: "Email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        customValidator: (value) {
                          if (value != null) {
                            String emailPattern =
                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
                            RegExp regExp = RegExp(emailPattern);

                            bool hasMatch = regExp.hasMatch(value);

                            if (!hasMatch) {
                              return "Enter valid email";
                            }
                            return null;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      submitButton(context),
                      CupertinoButton(
                        child: const Text("Back To Login"),
                        onPressed: () {
                          Navigator.of(context).pop();
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

  Widget submitButton(BuildContext context) {
    return MutationWidget(
      options: GrapghQlClientServices().getMutateOptions(
        document: UserSchemas.forgetPasswordQuery,
        context: context,
        onCompleted: (value) {
          buildSnackBar(
            context: context,
            value: "A reset password link has been sent to your E-mail",
          );
        },
      ),
      builder: (runMutation, result) => CustomElevatedButton(
        isLoading: result?.isLoading ?? false,
        title: "Submit",
        onPressed: () {
          bool isValid = _formKey.currentState?.validate() ?? false;
          if (isValid) {
            String authority = GrapghQlClientServices.httpLink.uri.authority;

            String resetPasswordLink = "https://$authority/setpassword";

            runMutation(
              {
                "userDetails": {
                  "userName": usernameController.text.trim(),
                  "emailId": emailController.text.trim(),
                  "resetPWDLink": resetPasswordLink,
                }
              },
            );
          }
        },
        fgColor: kWhite,
      ),
    );
  }
}
