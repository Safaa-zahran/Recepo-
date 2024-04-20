import 'package:flutter/material.dart';
import 'package:posts_app/core/widgets/form_widgets/primary_button/simple_primary_button.dart';
import 'package:posts_app/view/screens/SignInForm.dart';
import 'package:sizer/sizer.dart';

import '../../../core/dialogs/confirmation_dialog.dart';
import '../../../core/generated/locale_keys.g.dart';
import '../../../core/services/secure_storage/secure_storage_service.dart';
import '../../../core/utils/colors_palette.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/utils/util_values.dart';
import '../../../core/widgets/app_logo.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: ColorsPalette.white,
      child: Column(
        children: [
          UtilValues.gap32,
          const AppLogo(size: 100),

          Spacer(),

          SizedBox(
            width: 40.w,
            child: SimplePrimaryButton(
              isLoading: _isLoading,
              label: LocaleKeys.drawerLogout,
              onPressed: logout,
            ),
          ),

          const SizedBox(
            height: 80,
          ),
          // const LanguageSwitcher(),
        ],
      ),
    );
  }

  logout() async {
    try {
      final confirmed = await ConfirmationDialog.show(
        context: context,
        title: LocaleKeys.drawerLogout,
        message: LocaleKeys.logoutConfirmation,
      );

      if (!confirmed) return;

      setState(() => _isLoading = true);
      await SecureStorageService.instance.deleteAllData();
      Navigator.pushReplacementNamed(context, SignInForm.routeName);
    } catch (error) {
      showSnackbar(
        context: context,
        status: SnackbarStatus.error,
        message: error.toString(),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
