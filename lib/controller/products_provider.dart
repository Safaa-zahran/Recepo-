import 'dart:io';

import 'package:flutter/material.dart';
import 'package:posts_app/core/services/http/apis/miscellaneous_api.dart';
import 'package:posts_app/model/comments_model.dart';

import '../model/image_model.dart';
import '../model/products_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductsModel> posts = [];
  List<CommentsModel> comments = [];

  Future<void> getProducts(context) async {
    try {
      posts = await MiscellaneousApi.getProducts(context);
    } catch (_) {
      posts = [];
    }
    notifyListeners();
  }

  Future<void> getComments({required int id}) async {
    try {
      comments = await MiscellaneousApi.getComments(id: id);
    } catch (_) {
      comments = [];
    }
    notifyListeners();
  }

  Future<void> deletePost({required int id, required context}) async {
    try {
      await MiscellaneousApi.deletePost(id: id);
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
