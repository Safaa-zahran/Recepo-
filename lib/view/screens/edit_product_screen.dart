import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:posts_app/controller/products_provider.dart';
import 'package:posts_app/view/screens/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/colors_palette.dart';
import '../../core/utils/snackbars.dart';
import '../../core/utils/util_values.dart';
import '../../core/widgets/form_widgets/text_input_field.dart';
import '../../core/widgets/loading_widget.dart';
import '../../model/products_model.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/editProduct';

  const EditProductScreen({super.key, this.productsModel});
  final ProductsModel? productsModel;
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  var _priceController = TextEditingController();

  var _titleController = TextEditingController();

  bool _loading = false;
  bool showSniper = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ModalProgressHUD(
          inAsyncCall: showSniper,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: (imageId == null || imageId!.isEmpty)
                      ? Image.network(
                          widget.productsModel?.image ?? '',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          File(imageId ?? ''),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                titleFormField(),
                SizedBox(
                  height: 1.h,
                ),
                priceFormField(),
                SizedBox(
                  height: 6.h,
                ),
                uploadedImageWidget(),
                SizedBox(
                  height: 6.h,
                ),
                _addProductButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleFormField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextInputField(
        padding: EdgeInsets.all(2),
        focusedBorder: OutlineInputBorder(
          borderRadius: UtilValues.borderRadius10,
          borderSide: BorderSide(color: ColorsPalette.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: UtilValues.borderRadius10,
          borderSide:
              BorderSide(color: ColorsPalette.grey.withOpacity(0.4), width: 1),
        ),
        color: ColorsPalette.darkGrey,
        backgroundColor: ColorsPalette.white,
        controller: _titleController,
        inputType: TextInputType.name,
        name: widget.productsModel?.title ?? '',
        key: const ValueKey('title'),
        hint: widget.productsModel?.title ?? '',
        prefixIcon: const Icon(Icons.title),
        validator: FormBuilderValidators.required(),
      ),
    );
  }

  Widget priceFormField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextInputField(
        padding: EdgeInsets.all(2),
        focusedBorder: OutlineInputBorder(
          borderRadius: UtilValues.borderRadius10,
          borderSide: BorderSide(color: ColorsPalette.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: UtilValues.borderRadius10,
          borderSide:
              BorderSide(color: ColorsPalette.grey.withOpacity(0.4), width: 1),
        ),
        color: ColorsPalette.darkGrey,
        backgroundColor: ColorsPalette.white,
        controller: _priceController,
        inputType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        name: widget.productsModel?.price.toString() ?? '',
        key: const ValueKey('price'),
        hint: widget.productsModel?.price.toString() ?? '',
        prefixIcon: const Icon(Icons.monetization_on_outlined),
        validator: FormBuilderValidators.required(),
      ),
    );
  }

  void addProduct() async {
    try {
      final formState = _formKey.currentState ?? _formKey.currentState;
      if (formState!.validate()) {
        setState(() => _loading = true);
        if (imageId == null || imageId!.isEmpty) {
          showSnackbar(
            context: context,
            status: SnackbarStatus.error,
            message: 'you should select image',
          );
          return;
        }

        // final i = await context.read<ProductsProvider>().getImage(
        //       imageName: File(imageId ?? ''),
        //     );
        if (imageUrl == null || imageUrl!.isEmpty) {
          showSnackbar(
            context: context,
            status: SnackbarStatus.error,
            message: 'an error with image',
          );
          return;
        }

        await context.read<ProductsProvider>().addProduct(
            price: double.tryParse(_priceController.text),
            title: _titleController.text,
            image: imageUrl ?? '',
            context: context);
        Navigator.pushReplacementNamed(context, ProductsScreen.routeName);
      }
    } catch (e) {
      showSnackbar(
        context: context,
        status: SnackbarStatus.error,
        message: e.toString(),
      );
      setState(() => _loading = false);
    } finally {
      setState(() => _loading = false);
    }
  }

  _addProductButton() {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 2.h),
      margin: EdgeInsets.all(1.sp),
      width: 40.w,
      height: 6.h,
      child: ElevatedButton(
        onPressed: addProduct,
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              fontSize: 14.sp,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.purple),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
        ),
        child: Center(
          child: _loading
              ? LoadingWidget()
              : Text(
                  'Edit Product',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
        ),
      ),
    );
  }

  Widget uploadedImageWidget() {
    return Column(
      children: [
        Text(
          'Upload Photo',
          maxLines: 3,
        ),
        TextButton(
          onPressed: openImagePickerDialogue,
          child: Text('Upload'),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageId != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.file(
                  File(imageId ?? ''),
                  width: 40,
                  height: 40,
                  fit: BoxFit.fill,
                ),
              ),
            SizedBox(
              width: 5,
            ),
            Text(imageResponse ?? ''),
          ],
        ),
      ],
    );
  }

  void openImagePickerDialogue() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(
              'Upload Photo Choose Selection',
            ),
            content: SizedBox(
              height: 170,
              child: Column(
                children: [
                  Text(
                    'ImageAlertHeader',
                    maxLines: 4,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildFromGalleryButton(),
                  buildFromCameraButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildFromGalleryButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
      onPressed: () {
        Navigator.pop(context);
        getImage(ImageSource.gallery);
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Icon(Icons.image),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              'Upload From Gallery',
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFromCameraButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
      onPressed: () {
        Navigator.pop(context);
        getImage(ImageSource.camera);
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Icon(Icons.camera),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              'Upload From Camera',
            ),
          ),
        ],
      ),
    );
  }

  String? imageUrl;
  String? imageId;
  String? imageResponse;

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    final pickedFile = await picker.pickImage(source: media);
    if (pickedFile != null) {
      try {
        final response = await context
            .read<ProductsProvider>()
            .uploadImage(image: File(pickedFile.path));

        setState(() {
          imageUrl = response?.url;
          imageId = pickedFile.path;
          imageResponse = pickedFile.name;
        });
      } catch (ex) {
        showSnackbar(
          context: context,
          status: SnackbarStatus.error,
          message: ex.toString(),
        );
        // addError(error: ex.toString());
      }
    }
  }
}
