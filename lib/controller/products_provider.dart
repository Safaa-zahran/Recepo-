import 'dart:io';

import 'package:flutter/material.dart';
import 'package:posts_app/core/services/http/apis/miscellaneous_api.dart';

import '../model/image_model.dart';
import '../model/products_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductsModel> posts = [];

  Future<void> getProducts(context) async {
    try {
      posts = await MiscellaneousApi.getProducts(context);
    } catch (_) {
      posts = [];
    }
    notifyListeners();
  }

  Future<void> deleteProduct({required int id, required context}) async {
    try {
      await MiscellaneousApi.deleteProduct(id: id);
      await getProducts(context);
    } catch (_) {}
    notifyListeners();
  }

  Future<void> addProduct(
      {required double? price,
      required String? title,
      required String? image,
      required context}) async {
    try {
      await MiscellaneousApi.addProduct(
          price: price, title: title, image: image);
      await getProducts(context);
    } catch (_) {}
    notifyListeners();
  }

  Future<ImageModel?> uploadImage({
    required File? image,
  }) async {
    try {
      final response = await MiscellaneousApi.uploadImage(image: image);
      return response;
    } catch (_) {
      return null;
    }
    notifyListeners();
  }

  Future<void> editProduct(
      {required double? price,
      required String? title,
      required String? image,
      required int id,
      required context}) async {
    try {
      await MiscellaneousApi.editProduct(
          price: price, title: title, image: image, id: id);
      await getProducts(context);
    } catch (_) {}
    notifyListeners();
  }
}
