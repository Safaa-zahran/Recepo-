import 'package:flutter/material.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/font.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:posts_app/core/widgets/app_logo.dart';
import 'package:sizer/sizer.dart';

import 'contained_icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final backButton;

  const CustomAppBar(
      {Key? key, this.title, this.actions, this.bottom, this.backButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backButton != null
          ? const BackButton(
              color: ColorsPalette.lightGrey,
            )
          : Container(),
      elevation: 0,
      backgroundColor: ColorsPalette.black,
      iconTheme: const IconThemeData(color: ColorsPalette.black),
      centerTitle: true,
      title: Builder(builder: (context) {
        if (title == null) {
          return const AppLogo(size: 35);
        }
        return Text(
          title!,
          style: const TextStyle(
              fontSize: 16,
              color: ColorsPalette.lightGrey,
              fontFamily: NSTextStyles.font),
        );
      }),
      actions: [
        if (actions != null)
          ...actions!
        else
          Container(
            width: 18.w,
          )
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(56 + (bottom?.preferredSize.height ?? 0.0));
}

class CustomAppBarWithSearch extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final BackButton? backButton;
  final TextEditingController? searchController;
  final void Function(String?) onSearchFieldChanged;

  const CustomAppBarWithSearch(
      {Key? key,
      this.title,
      this.actions,
      this.bottom,
      this.backButton,
      this.searchController,
      required this.onSearchFieldChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: UtilValues.padding12,
        child: ContainedIconButton(
          backgroundColor: ColorsPalette.customGrey,
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: ColorsPalette.lightGrey,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      elevation: 0,
      backgroundColor: ColorsPalette.black,
      iconTheme: const IconThemeData(color: ColorsPalette.black),
      centerTitle: true,
      /*title: SizedBox(
        height: 10.h,
        width: 50.w,
        child: TextInputField(
          controller: searchController,
//          backgroundColor: ColorsPalette.white,
          name: 'search',
          hint: LocaleKeys.search.tr(),
          borderRadius: UtilValues.borderRadius10,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          padding: const EdgeInsets.all(10.5),
          //onSave: widget.onSearchFieldChanged,
          onChanged: onSearchFieldChanged,
        ),
      ),*/
      actions: [
        if (actions != null)
          ...actions!
        else
          Container(
            width: 18.w,
          )
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(56 + (bottom?.preferredSize.height ?? 0.0));
}
