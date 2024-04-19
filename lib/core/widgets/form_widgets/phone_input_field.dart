import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../utils/colors_palette.dart';
import '../../utils/util_values.dart';

class PhoneInputField extends StatelessWidget {
  final String name;
  final String hint;
  final String? Function(String?)? validator;
  final EdgeInsets? padding;
  final Function(String?)? onChanged;
  final String? initialValue;
  final IsoCode? defaultCountry;
  final Function(PhoneNumber?)? onSave;

  const PhoneInputField({
    Key? key,
    required this.name,
    required this.hint,
    this.validator,
    this.padding,
    this.onChanged,
    this.initialValue,
    this.defaultCountry,
    this.onSave
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: name,
      validator: validator,
      initialValue: initialValue,
      builder: (field) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: PhoneFormField(
            onSaved: onSave,
            initialValue:
                initialValue != null ? PhoneNumber.parse(initialValue!) : null,
            countrySelectorNavigator:
                const CountrySelectorNavigator.draggableBottomSheet(
              scrollPhysics: UtilValues.scrollPhysics,
            ),
            onChanged: (phone) {
              if (phone != null && phone.nsn.isNotEmpty) {
                field.didChange(phone.international);
              } else {
                field.didChange(null);
              }
            },
            defaultCountry: defaultCountry ?? IsoCode.EG,
            countryCodeStyle: const TextStyle(
                color: ColorsPalette.veryDarkGrey, fontSize: 13),
            style: const TextStyle(fontSize: 13),
            cursorColor: ColorsPalette.primaryColor,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: padding,
              isDense: true,
              border: _border,
              filled: true,
              fillColor: ColorsPalette.lightGrey,
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 13),
              errorText: field.errorText,
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder get _border => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: UtilValues.borderRadius10,
      );
}
