import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/view/screens/SignInForm.dart';

import '../../../../model/comments_model.dart';
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

  static Future<List<CommentsModel>> getComments({required int id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'posts/$id/comments',
      );

      return List<CommentsModel>.from(response.data
          .map((comment) => CommentsModel.fromJson(comment))
          .toList());
    } catch (error) {
      return [];
    }
  }

  static Future<ProductsModel> getPost({required int id}) async {
    try {
      final response = await ApiClient.instance.dio.get(
        'posts/$id',
      );

      return ProductsModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> deletePost({required int id}) async {
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
      throw LocaleKeys.genericErrorMessage.tr();
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
      throw LocaleKeys.genericErrorMessage.tr();
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
      throw LocaleKeys.genericErrorMessage.tr();
    }
  }

  // static Future<String> getImage({required File? imageName}) async {
  //   try {
  //     final i = await MultipartFile.fromFile('${imageName?.path}');
  //     // FormData file = FormData.fromMap({'file': i});
  //     final response = await ApiClient.instance.dio.get(
  //       'api/upload/${i.filename}',
  //       options: Options(headers: authHeader),
  //     );
  //     return response.data;
  //   } on DioError catch (error) {
  //     Helpers.debugDioError(error);
  //     rethrow;
  //   } catch (error) {
  //     log(error.toString());
  //     throw LocaleKeys.genericErrorMessage.tr();
  //   }
  // }

  static Future<void> editProduct(
      {required double? price,
      required String? title,
      required String? image,
      required int id}) async {
    try {
      // final file = await h.MultipartFile.fromPath('image', image ?? '',
      //     contentType: MediaType('image', 'jpg'));
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
      throw LocaleKeys.genericErrorMessage.tr();
    }
  }
}
