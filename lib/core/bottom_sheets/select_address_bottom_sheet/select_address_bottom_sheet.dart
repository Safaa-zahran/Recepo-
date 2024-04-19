/*
import 'package:easy_localization/easy_localization.dart';
import 'package:posts_app/core/bottom_sheets/select_address_bottom_sheet/local_widgets/address_item.dart';
import 'package:posts_app/core/controller/address_provider.dart';
import 'package:posts_app/core/generated/locale_keys.g.dart';
import 'package:posts_app/core/screens/add_new_address_screen.dart';
import 'package:posts_app/core/utils/colors_palette.dart';
import 'package:posts_app/core/utils/helpers.dart';
import 'package:posts_app/core/utils/util_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectAddressBottomSheet extends StatelessWidget {
  const SelectAddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: UtilValues.padding16,
          child: Text(
            LocaleKeys.choseDelivery.tr(),
            style: const TextStyle(
              color: ColorsPalette.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Consumer<AddressProvider>(
          builder: (_, addressProvider, child) {
            return Column(
              children: [
                ...addressProvider.addresses.map((address) {
                  return Column(
                    children: [
                      AddressItem(
                        addressName: address.name!,
                        address: Helpers.formatAddress(address),
                        onTap: () {
                          addressProvider.selectedAddress = address;
                          Navigator.of(context).pop();
                        },
                      ),
                      const Divider(
                        height: 0,
                        thickness: 0.25,
                        color: ColorsPalette.darkGrey,
                      )
                    ],
                  );
                }).toList(),
                child!,
              ],
            );
          },
          child: AddressItem(
            locationIcon: Icons.my_location_rounded,
            addressName: LocaleKeys.deliverToDifferent.tr(),
            address: LocaleKeys.addressFromMap.tr(),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AddNewAddressScreen.routeName);
            },
          ),
        ),
      ],
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: UtilValues.borderRadius10),
      builder: (context) {
        return const SelectAddressBottomSheet();
      },
    );
  }
}
*/
