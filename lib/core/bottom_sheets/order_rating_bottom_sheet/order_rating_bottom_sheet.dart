import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:posts_app/core/bottom_sheets/order_rating_bottom_sheet/rating_bar.dart';
import 'package:posts_app/core/generated/locale_keys.g.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/snackbars.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/core/widgets/form_widgets/primary_button/simple_primary_button.dart';
import 'package:posts_app/core/widgets/form_widgets/text_input_field.dart';

class OrderRatingBottomSheet extends StatefulWidget {
  final int orderId;

  const OrderRatingBottomSheet({super.key, required this.orderId});

  @override
  State<OrderRatingBottomSheet> createState() => _OrderRatingBottomSheetState();

  static Future<dynamic> show({
    required BuildContext context,
    required int orderId,
  }) async {
    return await showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: UtilValues.borderRadius10),
      builder: (context) {
        return OrderRatingBottomSheet(
          orderId: orderId,
        );
      },
    );
  }
}

class _OrderRatingBottomSheetState extends State<OrderRatingBottomSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  double? _orderRating;
  double? _driverRating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UtilValues.padding16,
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UtilValues.gap8,
            Text(
              LocaleKeys.shareUsYourFeedback.tr(),
              style: const TextStyle(
                color: ColorsPalette.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            UtilValues.gap24,
            LabeledRatingBar(
              label: LocaleKeys.rateTheOrder.tr(),
              onRatingChange: (rating) {
                _orderRating = rating;
              },
            ),
            UtilValues.gap16,
            LabeledRatingBar(
              label: LocaleKeys.rateTheDriver.tr(),
              onRatingChange: (rating) {
                _driverRating = rating;
              },
            ),
            UtilValues.gap24,
            TextInputField(
              name: 'message',
              hint: LocaleKeys.message.tr(),
              maxLines: 5,
            ),
            UtilValues.gap16,
            SimplePrimaryButton(
              isLoading: _isLoading,
              label: LocaleKeys.submit.tr(),
              onPressed: _submit,
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }

  void _submit() async {
    try {
      if (_orderRating == null) {
        _showErrorSnackBar(LocaleKeys.pleaseRateOrderFrom1To5.tr());
        return;
      }
      if (_driverRating == null) {
        _showErrorSnackBar(LocaleKeys.pleaseRateDriverFrom1To5.tr());
        return;
      }

      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        final messageFieldValue = _formKey.currentState!.value['message'];
        final message = (messageFieldValue == null || messageFieldValue == '')
            ? null
            : messageFieldValue;

        setState(() => _isLoading = true);

        /*await OrdersApi.rateOrder(
          orderId: widget.orderId,
          orderRate: _orderRating!.toInt(),
          driverRate: _driverRating!.toInt(),
          message: message,
        );*/

        showSnackbar(
          context: context,
          status: SnackbarStatus.success,
          message: LocaleKeys.thanksForYourRating.tr(),
        );

        Navigator.of(context).pop();
      }
    } catch (error) {
      _showErrorSnackBar(error.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String error) {
    showSnackbar(
      context: context,
      status: SnackbarStatus.error,
      message: error,
    );
  }
}
