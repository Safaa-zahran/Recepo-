/*
import 'package:posts_app/core/bottom_sheets/select_branch_bottom_sheet/radio.dart';
import 'package:posts_app/core/screens/main_screen/main_screen.dart';
import 'package:posts_app/core/utils/assets_manager.dart';
import 'package:posts_app/core/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../generated/locale_keys.g.dart';
import '../../model/branches.dart';
import '../../services/http/apis/miscellaneous_api.dart';
import '../../services/http/interceptors/api_interceptor.dart';
import '../../utils/colors_palette.dart';
import '../../utils/helpers.dart';
import '../../utils/size_config.dart';
import '../../utils/util_values.dart';
import '../../widgets/form_widgets/text_input_field.dart';
import '../../widgets/loading_widget.dart';

class SelectBranchBottomSheet extends StatefulWidget {
  const SelectBranchBottomSheet({Key? key}) : super(key: key);

  @override
  State<SelectBranchBottomSheet> createState() => _SelectBranchBottomSheetState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: UtilValues.borderRadius10),
      builder: (context) {
        return const SelectBranchBottomSheet();
      },
    );
  }
}

class _SelectBranchBottomSheetState extends State<SelectBranchBottomSheet> {

  bool _isLoadingBranch = false;
  List<Branches> _fetchedBranches = [];
  late Branches branches;
  //late Branches branches;
  bool _reachedEndOfBranches = false;
  String? _searchQuery;
  //List<Branches> branches = [];
  Data? _selectSchedule;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MiscellaneousApi.getBranches().then((value) {
      setState(() => branches = value);
    });

    if (_reachedEndOfBranches || _searchQuery != null) return;

            MiscellaneousApi.getBranches().then(
                  (products) {

               */
/* if (products.length < _pageSize) {
                  _reachedEndOfBranches = true;
                }*//*


                _fetchedBranches.addAll([products]);
                //_isLoadingMoreProducts = false;

                setState(() {});
              },
            );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*.6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: UtilValues.padding24T12,
            child: TextInputField(
              name: 'search',
              hint: LocaleKeys.search.tr(),
              borderRadius: UtilValues.borderRadius10,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              padding: const EdgeInsets.all(15.5),
              onChanged: _onSearchFieldChanged,
            ),
          ),
          FutureBuilder<Branches>(
            future: _searchQuery != null ? MiscellaneousApi.searchForBranches(searchQuery: _searchQuery!) : MiscellaneousApi.getBranches(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: ColorsPalette.white,
                      borderRadius: UtilValues.borderRadius25,
                    ),
                    child: const Center(
                      child: LoadingWidget(),
                    ),
                  ),
                );
              }
              final branches = snapshot.data!;
              return Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index){
                      return UtilValues.gap2;
                    },
                    itemCount: branches.data!.length,
                    itemBuilder: (context, index){
                      return Container(
                        height: Helpers.isEnglish(context) ? 120 : 125,
                          padding: UtilValues.padding16,
                          margin: const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 10),
                          decoration: BoxDecoration(color: ColorsPalette.lightGrey,
                            borderRadius: UtilValues.borderRadius10,),
                          child: Row(
                          children: [
                            RadioCard(
                                value: branches.data![index].id,
                                onChanged: (_) => _onSelectSizeOption(branches.data![index]),
                               selectedValue: _selectSchedule?.id,),
                            UtilValues.gap12,
                             Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(AssetsManager.pin, width: 15, height: 15,),
                                            Text(branches.data![index].location != null ? Helpers.isEnglish(context)
                                                ? branches.data![index].name.toString() : branches.data![index].nameAr.toString() : '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                          ],
                                        ),
                                        Padding(
                                          padding: UtilValues.paddinglrt,
                                          child: SizedBox(
                                              width:70,
                                              child: Text(branches.data![index].location != null ? branches.data![index].location!.street.toString() : '', style: const TextStyle(fontSize: 15, color: ColorsPalette.darkGrey), maxLines: 1,)),
                                        ),
                                        UtilValues.gap8,
                                        Padding(
                                          padding: UtilValues.paddinglrt,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Helpers.isEnglish(context) ? Text(branches.data![index].status == StatusUnit.open ? 'Open' : 'Close', style: const TextStyle(color: ColorsPalette.primaryColor, fontWeight: FontWeight.w400),) :  Text(branches.data![index].status == StatusUnit.open ? 'مفتوح' : 'مغلق', style: const TextStyle(color: ColorsPalette.primaryColor, fontWeight: FontWeight.w400),),
                                              UtilValues.gap8,
                                              Helpers.isEnglish(context) ? Text('${branches.data![index].openHour.toString()} am - ') : Text('${branches.data![index].openHour.toString()} ص - '),
                                              Helpers.isEnglish(context) ? Text('${branches.data![index].closeHour.toString()} am') : Text('${branches.data![index].closeHour.toString()} ص '),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    //Text(branches.data![index].id.toString()),
                                  ],
                                ),
                          ],
                          )
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onSelectSizeOption(Data sizeOption) {
    setState(() {
      if (_selectSchedule?.id != sizeOption.id*/
/* && _selectSchedule?.id == null*//*
) {
        _selectSchedule = sizeOption;
        selectedBranch = sizeOption.id!;
        selectedBranchName = Helpers.isArabic(context) ? sizeOption.nameAr : sizeOption.name;
      }
    });
    print('wwww $selectedBranch');
    print('ssss ${sizeOption.id!}');
    showSnackbar(context: context, status: SnackbarStatus.success, message: 'You Select ${sizeOption.nameAr} branch');
    Navigator.push(context, MaterialPageRoute(builder: (context){

      return MainScreen(index: 0, categoryId: 0,);

    }));
  }

  Future<void> _onSearchFieldChanged(String? searchQuery) async {
    try {
      setState(() => _isLoadingBranch = true);

      //_reachedEndOfBranches = false;

      if (searchQuery == null || searchQuery.isEmpty) {
        _searchQuery = null;
        branches = await MiscellaneousApi.getBranches();
        return;
      }
      setState(() {

      });
      _searchQuery = searchQuery;
      branches = await MiscellaneousApi.searchForBranches(
        searchQuery: searchQuery,
      );
      setState(() {

      });
    } finally {
      setState(() => _isLoadingBranch = false);
    }
  }

}
*/
