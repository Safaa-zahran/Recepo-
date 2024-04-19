import 'package:posts_app/core/generated/locale_keys.g.dart';
import 'package:posts_app/core/widgets/message_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/colors_palette.dart';

class LoginNowMessage extends StatelessWidget {
  const LoginNowMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      iconColor: ColorsPalette.darkGrey,
      icon: Icons.person_pin,
      message: LocaleKeys.loginToStartManagingOrders.tr(),
      actionButtonLabel: LocaleKeys.login.tr(),
      onActionButtonTapped: ()
      {
        //Navigator.of(context).pushNamed(AuthScreen.routeName);
    },
    );
  }
}
