import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eClassify/Utils/api.dart';
import 'package:eClassify/data/model/data_output.dart';
import 'package:eClassify/data/model/item/item_model.dart';

import '../../model/item_filter_model.dart';

class ItemRepository {
  Future<ItemModel> createItem(
    Map<String, dynamic> itemDetails,
    File mainImage,
    List<File> otherImages,
  ) async {
    try {
      Map<String, dynamic> parameters = {};
      parameters.addAll(itemDetails);

      // Main image
      MultipartFile image = await MultipartFile.fromFile(mainImage.path);



      List<Future<MultipartFile>> futures = otherImages.map((imageFile) {
        return MultipartFile.fromFile(imageFile.path);
      }).toList();

      List<MultipartFile> galleryImages = await Future.wait(futures);

      parameters.addAll({
        "image": image,
        "gallery_images": galleryImages,
        "show_only_to_premium": 1,
      });



      Map<String, dynamic> response = await Api.post(
        url: Api.addItemApi,
        parameter: parameters, /* useAuthToken: true*/
      );

      return ItemModel.fromJson(response['data'][0]);
    } catch (e, st) {

      rethrow;
    }
  }

  Future<DataOutput<ItemModel>> fetchMyFeaturedItems({int? page}) async {
    try {
      Map<String, dynamic> parameters = {"status": "featured", "page": page};

      Map<String, dynamic> response = await Api.get(
        url: Api.getMyItemApi,
        queryParameters: parameters, /*useAuthToken: true*/
      );
      List<ItemModel> itemList = (response['data']['data'] as List)
          .map((element) => ItemModel.fromJson(element))
          .toList();

      return DataOutput(
          total: response['data']['total'] ?? 0, modelList: itemList);
    } catch (e, st) {

      rethrow;
    }
  }

  Future<DataOutput<ItemModel>> fetchMyItems(
      {String? getItemsWithStatus, int? page}) async {
    try {
      Map<String, dynamic> parameters = {
        if (getItemsWithStatus != null) "status": getItemsWithStatus,
        if (page != null) Api.page: page
      };

      if (parameters['status'] == "") parameters.remove('status');
      Map<String, dynamic> response = await Api.get(
        url: Api.getMyItemApi,
        queryParameters: parameters, /*useAuthToken: true*/
      );
      List<ItemModel> itemList = (response['data']['data'] as List)
          .map((element) => ItemModel.fromJson(element))
          .toList();

      return DataOutput(
          total: response['data']['total'] ?? 0, modelList: itemList);
    } catch (e, st) {

      rethrow;
    }
  }

  Future<DataOutput<ItemModel>> fetchItemFromItemId(int id) async {
    Map<String, dynamic> parameters = {
      Api.id: id,
    };

    Map<String, dynamic> response = await Api.get(
      url: Api.getItemApi,
      queryParameters: parameters,
    );

    List<ItemModel> modelList = (response['data']['data'] as List)
        .map((e) => ItemModel.fromJson(e))
        .toList();

    return DataOutput(
        total: response['data']['total'] ?? 0, modelList: modelList);
  }

  Future<Map> changeMyItemStatus(
      {required int itemId, required String status}) async {
    Map response = await Api.post(url: Api.updateItemStatusApi, parameter: {
      "status": status,
      "item_id": itemId,
    });
    return response;
  }

  Future<Map> createFeaturedAds({required int itemId}) async {
    Map response = await Api.post(url: Api.makeItemFeaturedApi, parameter: {
      "item_id": itemId,
    });
    return response;
  }

  Future<DataOutput<ItemModel>> fetchItemFromCatId(
      {required int categoryId,
      required int page,
      String? search,
      String? sortBy,ItemFilterModel? filter}) async {
    Map<String, dynamic> parameters = {
      Api.categoryId: categoryId,
      Api.page: page,
      if (filter != null) ...filter.toMap(),
    };

    if (search != null) {
      parameters[Api.search] = search;
    }

    if (sortBy != null) {
      parameters[Api.sortBy] = sortBy;
    }

    Map<String, dynamic> response =
        await Api.get(url: Api.getItemApi, queryParameters: parameters);

    List<ItemModel> items = (response['data']['data'] as List)
        .map((e) => ItemModel.fromJson(e))
        .toList();

    return DataOutput(total: response['data']['total'] ?? 0, modelList: items);
  }

  Future<DataOutput<ItemModel>> fetchPopularItems(
      {required String sortBy, required int page}) async {
    Map<String, dynamic> parameters = {Api.sortBy: sortBy, Api.page: page};

    Map<String, dynamic> response =
        await Api.get(url: Api.getItemApi, queryParameters: parameters);

    List<ItemModel> items = (response['data']['data'] as List)
        .map((e) => ItemModel.fromJson(e))
        .toList();

    return DataOutput(total: response['data']['total'] ?? 0, modelList: items);
  }

  Future<ItemModel> editItem(
    Map<String, dynamic> itemDetails,
    File? mainImage,
    List<File>? otherImages,
  ) async {
    Map<String, dynamic> parameters = {};
    parameters.addAll(itemDetails);
    List<File> galleryImages = List<File>.from(otherImages ?? []);
    MultipartFile? image;
    if (mainImage != null) {
      image = await MultipartFile.fromFile(mainImage.path);
    }

    List<MultipartFile> multipartFiles =
        await _fileToMultipartFileList(galleryImages);

    if (image != null) {
      parameters['image'] = image;
    }
    if (multipartFiles.isNotEmpty) {
      parameters["gallery_images"] = multipartFiles;
    }

    Map<String, dynamic> response = await Api.post(
      url: Api.updateItemApi,
      parameter: parameters, /* useAuthToken: true*/
    );

    return ItemModel.fromJson(response['data'][0]);
  }

  Future<void> deleteItem(int id) async {
    await Api.post(
      url: Api.deleteItemApi,
      parameter: {Api.id: id}, /* useAuthToken: true*/
    );
  }

  Future<void> itemTotalClick(int id) async {
    Map<String, dynamic> response = await Api.post(
        url: Api.setItemTotalClickApi, parameter: {Api.itemId: id});


  }

  Future<Map> makeAnOfferItem(int id, int amount) async {
    Map response = await Api.post(
        url: Api.itemOfferApi, parameter: {Api.itemId: id, Api.amount: amount});
    return response;
  }

  Future<DataOutput<ItemModel>> searchItem(
      String query, ItemFilterModel? filter,
      {required int page}) async {
    Map<String, dynamic> parameters = {
      Api.search: query,
      Api.page: page,
      if (filter != null) ...filter.toMap(),
    };


    Map<String, dynamic> response =
        await Api.get(url: Api.getItemApi, queryParameters: parameters);

    List<ItemModel> items = (response['data']['data'] as List)
        .map((e) => ItemModel.fromJson(e))
        .toList();

    return DataOutput(total: response['data']['total'] ?? 0, modelList: items);
  }

  Future<List<MultipartFile>> _fileToMultipartFileList(List<File> files) async {
    List<MultipartFile> multipartFileList = [];
    for (File file in files) {
      multipartFileList.add(await MultipartFile.fromFile(file.path));
    }
    return multipartFileList;
  }
}