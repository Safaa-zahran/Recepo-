import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/controller/products_provider.dart';
import 'package:posts_app/view/screens/loca_widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

import '../../core/dialogs/confirmation_dialog.dart';
import '../../core/generated/locale_keys.g.dart';
import '../../core/utils/snackbars.dart';
import '../../core/utils/util_values.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/search_bar_widget.dart';
import '../../model/products_model.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';
import 'loca_widgets/custom_product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  static const String routeName = '/products';

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductsModel>? searchOptions;
  DateTime _backButtonTimestamp = DateTime.now();

  Future<bool> _doubleBackToExit(BuildContext context) async {
    final differenceBetweenNowAndLastTimestamp =
        DateTime.now().difference(_backButtonTimestamp);
    if (differenceBetweenNowAndLastTimestamp.inSeconds > 1) {
      showSnackbar(
        context: context,
        status: SnackbarStatus.info,
        message: LocaleKeys.doubleBackToExit.tr(),
      );
      _backButtonTimestamp = DateTime.now();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _doubleBackToExit(context),
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text('All Products'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              _search(),
              Expanded(
                child: FutureBuilder(
                    future:
                        Provider.of<ProductsProvider>(context, listen: false)
                            .getProducts(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: LoadingWidget(),
                        );
                      }

                      /*final ProductsProvider = context.read<ProductsProvider>();

                          final posts = ProductsProvider.posts;*/

                      final posts =
                          Provider.of<ProductsProvider>(context, listen: true)
                              .posts;

                      if (posts.isEmpty) {
                        return Center(child: Text('No Products Found'));
                      }
                      return Consumer<ProductsProvider>(
                          builder: (context, provide, _) {
                        // if(searchOptions == null && posts == null){
                        //   return Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // }
                        if ((searchOptions != null && searchOptions!.isEmpty) ||
                            (searchOptions == null && posts.isEmpty)) {
                          return Center(
                            child: Text('No Products Found'),
                          );
                        }
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final item = (searchOptions != null &&
                                    searchOptions!.isNotEmpty)
                                ? searchOptions![index]
                                : posts[index];
                            return Padding(
                              padding: UtilValues.padding8,
                              child: InkWell(
                                onTap: () {
                                  // Navigator.pushNamed(context, PostScreen.routeName, arguments: posts[index]);
                                },
                                child: CustomProductWidget(
                                  image: item.image ?? '',
                                  allPosts: true,
                                  voidCallbackUpdate: () =>
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                    return EditProductScreen(
                                      productsModel: item,
                                    );
                                  })),
                                  voidCallbackUpvote: () => _deletePost(
                                      id: item.id ?? 0, context: context),
                                  title: item.title ?? '',
                                  price: item.price ?? 1,
                                  numberOfReplies: 0,
                                ),
                              ),
                            );
                          },
                          itemCount: (searchOptions != null &&
                                  searchOptions!.isNotEmpty)
                              ? searchOptions?.length
                              : posts.length,
                        );
                      });
                    }),
              ),
            ],
          ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AddProductScreen.routeName);
          },
          child: Icon(
            Icons.add,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }

  _search() {
    return Consumer<ProductsProvider>(builder: (context, provide, _) {
      return SearchBarWidget(
        searchOptions: searchOptions,
        onTextChanged: (String value) {
          setState(() {
            searchOptions = provide.posts
                .where((option) =>
                    option.title!.toLowerCase().contains(value.toLowerCase()))
                .toList();
          });
        },
      );
    });
  }

  Future<void> _deletePost(
      {required int id, required BuildContext context}) async {
    try {
      final confirmed = await ConfirmationDialog.show(
        context: context,
        title: 'Are you sure?',
        message: 'You want to delete this product?',
      );

      if (!confirmed) return;
      await context
          .read<ProductsProvider>()
          .deletePost(id: id, context: context)
          .then((value) {
        showSnackbar(
          context: context,
          status: SnackbarStatus.success,
          message: 'Deleted successfully'.toString(),
        );
      });
      await context.read<ProductsProvider>().getProducts(context);
    } catch (error) {
      showSnackbar(
        context: context,
        status: SnackbarStatus.error,
        message: error.toString(),
      );
    }
  }
}
