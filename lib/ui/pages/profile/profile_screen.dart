import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nectar_assets/core/blocs/theme/theme_bloc.dart';
import 'package:nectar_assets/ui/pages/profile/pages/change_password_screen.dart';
import 'package:nectar_assets/ui/pages/profile/widgets/build_custom_listtile.dart';
import 'package:nectar_assets/ui/pages/profile/widgets/build_version_text.dart';
import 'package:nectar_assets/ui/pages/profile/widgets/bulid_logout_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:video_tutorials/video_tutorials.dart';
import 'widgets/build_details_and_edit_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String id = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          children: [
            const BuildDetailsAndEditButtonWidget(),
            const Divider(
              height: 30,
            ),
            themeChangingTile(context),
            // buildListTile(
            //   titleText: "Notification Subscribe",
            //   iconData: Icons.notifications_outlined,
            //   showForwardArrowIcon: true,
            //   trailing: Switch.adaptive(
            //     value: true,
            //     onChanged: (value) {},
            //   ),
            // ),
            PermissionChecking(
              featureGroup: "applicationAccess",
              feature: "login",
              permission: "mobile",
              child: BuildCustomListTile(
                titleText: "Change Password",
                iconData: Icons.password,
                showForwardArrowIcon: true,
                onTap: () {
                  Navigator.of(context).pushNamed(ChangePasswordScreen.id);
                },
              ),
            ),
            BuildCustomListTile(
              titleText: "Help",
              iconData: Icons.help_outline_outlined,
              showForwardArrowIcon: true,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const VideoTutorialScreen(
                    videoTutorialFolderId: VideoTutorialFolderId.esamNectarAssets,
                  ),
                ));
              },
            ),

            const Spacer(),
            const BuildLogoutWidget(),
            SizedBox(
              height: 20.sp,
            ),
            const BuildVersionText(),
            SizedBox(
              height: 3.sp,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================================

  Widget themeChangingTile(BuildContext context) {
    return BuildCustomListTile(
      titleText: "Dark Mode",
      iconData: Icons.contrast,
      onTap: () {
        ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);

        bool value = themeBloc.state.mode == ThemMode.dark;

        themeBloc.add(
          ChangeThemeModeEvent(
            themMode: value ? ThemMode.light : ThemMode.dark,
          ),
        );

        SharedPrefrencesServices.instance.setBool("isDarkMode", !value);
      },
      trailing: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Switch.adaptive(
            value: state.mode == ThemMode.dark,
            onChanged: (value) {
              ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);

              themeBloc.add(
                ChangeThemeModeEvent(
                  themMode: value ? ThemMode.dark : ThemMode.light,
                ),
              );

              SharedPrefrencesServices.instance.setBool("isDarkMode", value);
            },
          );
        },
      ),
    );
  }
}
