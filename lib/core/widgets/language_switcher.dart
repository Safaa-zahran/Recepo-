import 'package:easy_localization/easy_localization.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/helpers.dart';
import 'package:posts_app/core/widgets/form_widgets/primary_button/simple_primary_button.dart';
import 'package:flutter/material.dart';

import '../generated/locale_keys.g.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 40,
      child: SimplePrimaryButton(
        backgroundColor: ColorsPalette.lightGrey,
        labelColor: ColorsPalette.black,
        label: LocaleKeys.lang.tr(),
        onPressed: () async {
          if (Helpers.isEnglish(context)) {
            context.setLocale(const Locale('ar'));
          } else {
            context.setLocale(const Locale('en'));
          }
        },
      ),
    );
  }
}
