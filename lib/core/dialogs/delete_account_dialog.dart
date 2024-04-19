
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:posts_app/core/widgets/form_widgets/text_input_field.dart';

//import '../controller/user_provider.dart';
import '../generated/locale_keys.g.dart';
//import '../screens/main_screen/main_screen.dart';
import '../utils/colors_palette.dart';
import '../utils/snackbars.dart';
import '../utils/util_values.dart';
import '../widgets/form_widgets/primary_button/simple_primary_button.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();

  static Future<bool> show({
    required BuildContext context,
    String? title,
    String? message,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const DeleteAccountDialog(),
    );

    return confirmed ?? false;
  }
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      contentPadding: UtilValues.padding16,
      shape: RoundedRectangleBorder(borderRadius: UtilValues.borderRadius10),
      content: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UtilValues.gap8,
            Text(
              LocaleKeys.deleteAccount.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            UtilValues.gap16,
            Text(
              LocaleKeys.deleteAccountDialogBody.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(height: 1.3),
            ),
            UtilValues.gap24,
            TextInputField(
              inputType: TextInputType.emailAddress,
              name: 'email',
              hint: LocaleKeys.email.tr(),
              validator: FormBuilderValidators.required(),
            ),
            UtilValues.gap24,
            Row(
              children: [
                Expanded(
                  child: SimplePrimaryButton(
                    label: LocaleKeys.cancel.tr(),
                    backgroundColor: ColorsPalette.grey,
                    labelColor: ColorsPalette.black,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                UtilValues.gap16,
                Expanded(
                  child: SimplePrimaryButton(
                    isLoading: _isLoading,
                    label: LocaleKeys.deleteAccount.tr(),
                    onPressed: () => _deleteAccount(context),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      final formState = _formKey.currentState!;
      if (formState.saveAndValidate()) {
        final email = formState.value['email'];

        //final userProvider = context.read<UserProvider>();

        setState(() => _isLoading = true);

        //await userProvider.deleteAccount(email: email);

        showSnackbar(
          context: context,
          status: SnackbarStatus.success,
          message: LocaleKeys.accountDeletedSuccessfully.tr(),
        );

        Navigator.of(context).popUntil((route) => route.isFirst);
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(index: 0, categoryId: 0,)),
        );*/
      }
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
