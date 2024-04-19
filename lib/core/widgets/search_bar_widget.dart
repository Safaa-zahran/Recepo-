import 'package:flutter/material.dart';
import 'package:posts_app/core/generated/locale_keys.g.dart';
import 'package:posts_app/model/products_model.dart';

class SearchBarWidget extends StatefulWidget {
  final Function onTextChanged;
  //final Function()? onTap;
  List<ProductsModel>? searchOptions;

  SearchBarWidget({
    Key? key,
    required this.onTextChanged,
    required this.searchOptions,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final String searchIcon = "assets/icons/search_icon.svg";

  String searchText = '';

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 240, 238),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: searchController,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 22, 21, 21),
                        ),
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: LocaleKeys.search,
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                            //if (searchText.length > 2) {
                            widget.onTextChanged(searchText);
                            //}
                          });
                        },
                      ),
                    ),
                    if (searchText.isNotEmpty)
                      Positioned(
                          right: 10,
                          bottom: 1,
                          top: 1,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  searchText = '';
                                  searchController.clear();
                                  widget.onTextChanged(searchText);
                                  widget.searchOptions = null;
                                });
                              },
                              icon: Icon(Icons.clear)))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 45,
            height: 40,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple),
              ),
              onPressed: () {},
              child: const Icon(Icons.search),
            ),
          )
        ],
      ),
    );
  }
}
