import 'package:awesome_card/awesome_card.dart';
import 'package:posts_app/core/utils/app_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:posts_app/core/generated/locale_keys.g.dart';
//import 'package:posts_app/core/model/credit_card_data.dart';
//import 'package:posts_app/core/screens/payment_webview_screen.dart';
//import 'package:posts_app/core/services/http/apis/miscellaneous_api.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/snackbars.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/core/widgets/form_widgets/primary_button/simple_primary_button.dart';
import 'package:posts_app/core/widgets/form_widgets/secondary_button/simple_secondary_button.dart';
import 'package:posts_app/core/widgets/form_widgets/text_input_field.dart';

import '../../../model/credit_card_data.dart';

class CreditCardBottomSheet extends StatefulWidget {
  const CreditCardBottomSheet({super.key});
  @override
  State<CreditCardBottomSheet> createState() => _CreditCardBottomSheetState();

  static Future<dynamic> show(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: UtilValues.borderRadius10),
      builder: (context) {
        return const CreditCardBottomSheet();
      },
    );
  }
}

class _CreditCardBottomSheetState extends State<CreditCardBottomSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  final CreditCardData _creditCard = CreditCardData();

  late FocusNode _cvvFieldFocusNode;
  bool _showBackSide = false;

  @override
  void initState() {
    _cvvFieldFocusNode = FocusNode();
    _cvvFieldFocusNode.addListener(() {
      setState(() {
        _showBackSide = _cvvFieldFocusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UtilValues.padding16,
      child: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          physics: UtilValues.scrollPhysics,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreditCard(
                horizontalMargin: 0,
                cardNumber: _creditCard.number ?? 'XXXX XXXX XXXX XXXX',
                cardExpiry: _displayedExpiryDate,
                cardHolderName: _creditCard.holderName,
                cvv: _creditCard.cvv ?? 'XXX',
                bankName: AppConfig.appName,
                showBackSide: _showBackSide,
                frontBackground:
                    CardBackgrounds.custom(ColorsPalette.primaryColor.value),
                backBackground: CardBackgrounds.white,
                textExpDate: 'Exp. Date',
                textName: 'Card Holder Name',
              ),
              UtilValues.gap16,
              TextInputField(
                name: '0',
                hint: LocaleKeys.cardHolderName.tr(),
                inputType: TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    if (value == null || value.isEmpty) {
                      _creditCard.holderName = null;
                      return;
                    }

                    _creditCard.holderName = value;
                  });
                },
                validator: FormBuilderValidators.required(),
              ),
              UtilValues.gap16,
              TextInputField(
                name: '1',
                hint: LocaleKeys.cardNumber.tr(),
                maxLength: 16,
                inputType: const TextInputType.numberWithOptions(),
                onChanged: (value) {
                  setState(() {
                    if (value == null || value.isEmpty) {
                      _creditCard.number = null;
                      return;
                    }

                    _creditCard.number = value;
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.creditCard(),
                ]),
              ),
              UtilValues.gap16,
              Row(
                children: [
                  Expanded(
                    child: TextInputField(
                      name: '2',
                      hint: LocaleKeys.expiryMonth.tr(),
                      maxLength: 2,
                      inputType: const TextInputType.numberWithOptions(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null || value.isEmpty) {
                            _creditCard.expiryMonth = null;
                            return;
                          }

                          _creditCard.expiryMonth = value;
                        });
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.integer(),
                        FormBuilderValidators.min(1),
                        FormBuilderValidators.max(12),
                        FormBuilderValidators.minLength(1),
                        FormBuilderValidators.maxLength(2),
                      ]),
                    ),
                  ),
                  UtilValues.gap16,
                  Expanded(
                    child: TextInputField(
                      name: '3',
                      hint: LocaleKeys.expiryYear.tr(),
                      maxLength: 2,
                      inputType: const TextInputType.numberWithOptions(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null || value.isEmpty) {
                            _creditCard.expiryYear = null;
                            return;
                          }

                          _creditCard.expiryYear = value;
                        });
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.integer(),
                        FormBuilderValidators.equalLength(2),
                      ]),
                    ),
                  ),
                ],
              ),
              UtilValues.gap16,
              TextInputField(
                focusNode: _cvvFieldFocusNode,
                name: '4',
                hint: LocaleKeys.cvv.tr(),
                maxLength: 3,
                inputType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                    if (value == null || value.isEmpty) {
                      _creditCard.cvv = null;
                      return;
                    }

                    _creditCard.cvv = value;
                  });
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.maxLength(3),
                  FormBuilderValidators.minLength(3),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.integer(),
                ]),
              ),
              UtilValues.gap16,
              Row(
                children: [
                  Expanded(
                    child: SimpleSecondaryButton(
                      label: LocaleKeys.cancel.tr(),
                      onPressed: () => Navigator.of(context).pop(null),
                    ),
                  ),
                  UtilValues.gap16,
                  Expanded(
                    child: SimplePrimaryButton(
                      isLoading: _isLoading,
                      label: LocaleKeys.submit.tr(),
                      onPressed: _submit,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  String get _displayedExpiryDate {
    if (_creditCard.expiryMonth != null && _creditCard.expiryYear == null) {
      return '${_creditCard.expiryMonth}/XX';
    }

    if (_creditCard.expiryMonth == null && _creditCard.expiryYear != null) {
      return 'XX/${_creditCard.expiryYear}';
    }

    if (_creditCard.expiryMonth != null && _creditCard.expiryYear != null) {
      return '${_creditCard.expiryMonth}/${_creditCard.expiryYear}';
    }

    return 'XX/XX';
  }

  void _submit() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        setState(() => _isLoading = true);

        //final submittedCardResponse = await MiscellaneousApi.sendCardDetails(_creditCard);

        //final htmlBody = submittedCardResponse.htmlBody.replaceAll('\\', '');

        /*await Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return PaymentWebViewScreen(html: htmlBody);
            },
          ),
        );*/

        //Navigator.of(context).pop([_creditCard, submittedCardResponse]);
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
