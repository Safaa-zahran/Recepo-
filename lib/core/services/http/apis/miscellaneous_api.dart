import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/view/screens/SignInForm.dart';

import '../../../../model/image_model.dart';
import '../../../../model/products_model.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../utils/helpers.dart';
import '../api_client.dart';
import '../interceptors/api_interceptor.dart';

class MiscellaneousApi {
  static Future<List<ProductsModel>> getProducts(context) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'api/products/',
        options: Options(headers: authHeader),
      );
      return List<ProductsModel>.from(
          response.data.map((post) => ProductsModel.fromJson(post)).toList());
    } catch (error) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pushReplacementNamed(context, SignInForm.routeName),
      );
      return [];
    }
  }

  static Future<void> deleteProduct({required int id}) async {
    try {
      await ApiClient.instance.dio.delete(
        'api/products/?id=$id',
        options: Options(headers: authHeader),
      );
    } on DioError catch (error) {
      Helpers.debugDioError(error);
      rethrow;
    } catch (error) {
      log(error.toString());
      throw LocaleKeys.genericErrorMessage;
    }
  }

  static Future<void> addProduct(
      {required double? price,
      required String? title,
      required String? image}) async {
    try {
      // final file = await h.MultipartFile.fromPath('image', image ?? '',
      //     contentType: MediaType('image', 'jpg'));
      await ApiClient.instance.dio.post('api/products/',
          options: Options(headers: authHeader),
          data: {
            "title": title ?? '',
            "price": price ?? 1,
            "image": image ?? ""
          });
    } on DioError catch (error) {
      Helpers.debugDioError(error);
      rethrow;
    } catch (error) {
      log(error.toString());
      throw LocaleKeys.genericErrorMessage;
    }
  }

  static Future<ImageModel> uploadImage({required File? image}) async {
    try {
      final i = await MultipartFile.fromFile('${image?.path}');
      FormData file = FormData.fromMap({'file': i});

      final response = await ApiClient.instance.dio.post('api/upload/',
          options: Options(headers: authHeader), data: file);

      ImageModel imageModel = ImageModel.fromJson(response.data);

      return imageModel;
    } on DioError catch (error) {
      Helpers.debugDioError(error);
      rethrow;
    } catch (error) {
      log(error.toString());
      throw LocaleKeys.genericErrorMessage;
    }
  }

  static Future<void> editProduct(
      {required double? price,
      required String? title,
      required String? image,
      required int id}) async {
    try {
      await ApiClient.instance.dio.put('api/products/?id=$id',
          options: Options(headers: authHeader),
          data: {
            "title": title ?? '',
            "price": price ?? 1,
            "image": image ?? ""
          });
    } on DioError catch (error) {
      Helpers.debugDioError(error);
      rethrow;
    } catch (error) {
      log(error.toString());
      throw LocaleKeys.genericErrorMessage;
    }
  }
}
