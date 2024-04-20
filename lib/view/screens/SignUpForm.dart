import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:posts_app/controller/user_provider.dart';
import 'package:posts_app/view/screens/SignInForm.dart';
import 'package:posts_app/view/screens/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../core/generated/locale_keys.g.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/colors_palette.dart';
import '../../core/utils/snackbars.dart';
import '../../core/utils/util_values.dart';
import '../../core/widgets/form_widgets/ternary_button.dart';
import '../../core/widgets/form_widgets/text_input_field.dart';
import '../../core/widgets/loading_widget.dart';

class SignUpForm extends StatefulWidget {
  static const String routeName = '/signUp';

  SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  var _userNameController = TextEditingController();

  var _passwordController = TextEditingController();

  var _confirmPasswordController = TextEditingController();

  bool showSniper = false;

  bool showPass = true;

  bool showConfirmPass = true;
  bool _loading = false;

  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ModalProgressHUD(
            inAsyncCall: showSniper,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30.w,
                    height: 6.h,
                    child: Center(
                        child: Image.asset(
                      AssetsManager.splash,
                      color: Colors.purple,
                    )),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Recepo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Create new Account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  nameFormField(),
                  SizedBox(
                    height: 1.h,
                  ),
                  passwordFormField(),
                  SizedBox(
                    height: 1.h,
                  ),
                  confirmPasswordFormField(),
                  SizedBox(
                    height: 5.h,
                  ),
                  _signUpButton(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.haveAccount,
                        style: TextStyle(
                            color: ColorsPalette.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp),
                      ),
                      TernaryButton(
                          label: 'Sign In',
                          onTap: () {
                            Navigator.pushNamed(context, SignInForm.routeName);
                          }),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    try {
      final formState = _formKey.currentState ?? _formKey.currentState;
      if (formState!.validate() &&
          _confirmPasswordController.text == _passwordController.text) {
        setState(() => _loading = true);
        await context.read<UserProvider>().register(
            password: _passwordController.text,
            userName: _userNameController.text);
        setState(() => _loading = true);
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

  _signUpButton() {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 2.h),
      margin: EdgeInsets.all(1.sp),
      width: 35.w,
      height: 6.h,
      child: ElevatedButton(
        onPressed: signUp,
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
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
        ),
      ),
    );
  }

  Widget nameFormField() {
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
        controller: _userNameController,
        inputType: TextInputType.name,
        name: LocaleKeys.name,
        key: const ValueKey('name'),
        hint: LocaleKeys.name,
        prefixIcon: const Icon(Icons.person),
        validator: validateWordCount,
      ),
    );
  }

  Widget passwordFormField() {
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
            borderSide: BorderSide(
                color: ColorsPalette.grey.withOpacity(0.4), width: 1),
          ),
          color: ColorsPalette.darkGrey,
          backgroundColor: ColorsPalette.white,
          controller: _passwordController,
          inputType: TextInputType.name,
          obscured: showPass,
          name: LocaleKeys.password,
          key: const ValueKey('password'),
          hint: LocaleKeys.password,
          prefixIcon: const Icon(Icons.lock_outline),
          validator: validateWordCount,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPass = !showPass;
              });
            },
            icon: showPass
                ? Icon(
                    Icons.remove_red_eye,
                    color: Colors.purple,
                  )
                : Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.purple,
                  ),
          )),
    );
  }

  Widget confirmPasswordFormField() {
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
            borderSide: BorderSide(
                color: ColorsPalette.grey.withOpacity(0.4), width: 1),
          ),
          color: ColorsPalette.darkGrey,
          backgroundColor: ColorsPalette.white,
          controller: _confirmPasswordController,
          inputType: TextInputType.name,
          obscured: showConfirmPass,
          name: LocaleKeys.confirm,
          key: const ValueKey('confirm password'),
          hint: LocaleKeys.confirm,
          prefixIcon: const Icon(Icons.lock_outline),
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return 'Please enter your password';
          //   }
          //   if (value != _confirmPasswordController.text) {
          //     return 'Password does not match';
          //   }
          //   return null;
          // },
          validator: FormBuilderValidators.match(_passwordController.text),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showConfirmPass = !showConfirmPass;
              });
            },
            icon: showConfirmPass
                ? Icon(
                    Icons.remove_red_eye,
                    color: Colors.purple,
                  )
                : Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.purple,
                  ),
          )),
    );
  }

  String? validateWordCount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }

    if (value.length < 5) {
      return 'Please enter at least 5 words';
    }

    return null; // Return null if the input is valid
  }
}
