import 'dart:convert';

import 'package:flutter/foundation.dart';

class ShoppingItemsModel {
  final String title;
  final double mrpPrize;
  final double discountPrize;
  final double offerPercentage;
  final List<String> images;
  final List<PackSize> packSizes;
  final String? aboutProduct;
  final String? benefits;
  final String? otherProductInfo;
  final String id;
  final bool isPaid;

  ShoppingItemsModel({
    required this.title,
    required this.mrpPrize,
    required this.discountPrize,
    required this.offerPercentage,
    required this.images,
    required this.packSizes,
    this.aboutProduct,
    this.benefits,
    this.otherProductInfo,
    required this.id,
    this.isPaid = false,
  });

  ShoppingItemsModel copyWith({
    String? title,
    double? mrpPrize,
    double? discountPrize,
    double? offerPercentage,
    List<String>? images,
    List<PackSize>? packSizes,
    String? aboutProduct,
    String? benefits,
    String? otherProductInfo,
    String? id,
    bool? isPaid,
  }) {
    return ShoppingItemsModel(
      title: title ?? this.title,
      mrpPrize: mrpPrize ?? this.mrpPrize,
      discountPrize: discountPrize ?? this.discountPrize,
      offerPercentage: offerPercentage ?? this.offerPercentage,
      images: images ?? this.images,
      packSizes: packSizes ?? this.packSizes,
      aboutProduct: aboutProduct ?? this.aboutProduct,
      benefits: benefits ?? this.benefits,
      otherProductInfo: otherProductInfo ?? this.otherProductInfo,
      id: id ?? this.id,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'mrpPrize': mrpPrize});
    result.addAll({'discountPrize': discountPrize});
    result.addAll({'offerPercentage': offerPercentage});
    result.addAll({'images': images});
    result.addAll({'packSizes': packSizes.map((x) => x.toMap()).toList()});
    if (aboutProduct != null) {
      result.addAll({'aboutProduct': aboutProduct});
    }
    if (benefits != null) {
      result.addAll({'benefits': benefits});
    }
    if (otherProductInfo != null) {
      result.addAll({'otherProductInfo': otherProductInfo});
    }
    result.addAll({'id': id});
    result.addAll({'isPaid': isPaid});

    return result;
  }

  factory ShoppingItemsModel.fromMap(Map<String, dynamic> map) {
    return ShoppingItemsModel(
      title: map['title'] ?? '',
      mrpPrize: map['mrpPrize']?.toDouble() ?? 0.0,
      discountPrize: map['discountPrize']?.toDouble() ?? 0.0,
      offerPercentage: map['offerPercentage']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      packSizes: List<PackSize>.from(
          map['packSizes']?.map((x) => PackSize.fromMap(x))),
      aboutProduct: map['aboutProduct'],
      benefits: map['benefits'],
      otherProductInfo: map['otherProductInfo'],
      id: map['id'] ?? '',
      isPaid: map['isPaid'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingItemsModel.fromJson(String source) =>
      ShoppingItemsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShoppingItemsModel(title: $title, mrpPrize: $mrpPrize, discountPrize: $discountPrize, offerPercentage: $offerPercentage, images: $images, packSizes: $packSizes, aboutProduct: $aboutProduct, benefits: $benefits, otherProductInfo: $otherProductInfo, id: $id, isPaid: $isPaid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShoppingItemsModel &&
        other.title == title &&
        other.mrpPrize == mrpPrize &&
        other.discountPrize == discountPrize &&
        other.offerPercentage == offerPercentage &&
        listEquals(other.images, images) &&
        listEquals(other.packSizes, packSizes) &&
        other.aboutProduct == aboutProduct &&
        other.benefits == benefits &&
        other.otherProductInfo == otherProductInfo &&
        other.id == id &&
        other.isPaid == isPaid;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        mrpPrize.hashCode ^
        discountPrize.hashCode ^
        offerPercentage.hashCode ^
        images.hashCode ^
        packSizes.hashCode ^
        aboutProduct.hashCode ^
        benefits.hashCode ^
        otherProductInfo.hashCode ^
        id.hashCode ^
        isPaid.hashCode;
  }
}

class PackSize {
  final String pieces;
  final String weight;
  final double mrpPrize;
  final double discountPrize;
  final double offerPercentage;

  PackSize({
    required this.pieces,
    required this.weight,
    required this.mrpPrize,
    required this.discountPrize,
    required this.offerPercentage,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pieces': pieces});
    result.addAll({'weight': weight});
    result.addAll({'mrpPrize': mrpPrize});
    result.addAll({'discountPrize': discountPrize});
    result.addAll({'offerPercentage': offerPercentage});

    return result;
  }

  factory PackSize.fromMap(Map<String, dynamic> map) {
    return PackSize(
      pieces: map['pieces'] ?? '',
      weight: map['weight'] ?? '',
      mrpPrize: map['mrpPrize']?.toDouble() ?? 0.0,
      discountPrize: map['discountPrize']?.toDouble() ?? 0.0,
      offerPercentage: map['offerPercentage']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackSize.fromJson(String source) =>
      PackSize.fromMap(json.decode(source));
}
//////////////

class ShoppingCartItemsModel {
  final String title;
  final double discountPrize;
  final List<String> images;
  final int selectedItemCount;
  final String id;
  final bool isPaid;

  ShoppingCartItemsModel({
    required this.title,
    required this.discountPrize,
    required this.images,
    required this.selectedItemCount,
    required this.id,
    required this.isPaid,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'discountPrize': discountPrize});
    result.addAll({'images': images});
    result.addAll({'selectedItemCount': selectedItemCount});
    result.addAll({'id': id});
    result.addAll({'isPaid': isPaid});

    return result;
  }

  factory ShoppingCartItemsModel.fromMap(Map<String, dynamic> map) {
    return ShoppingCartItemsModel(
      title: map['title'] ?? '',
      discountPrize: map['discountPrize']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      selectedItemCount: map['selectedItemCount']?.toInt() ?? 0,
      id: map['id'] ?? '',
      isPaid: map['isPaid'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingCartItemsModel.fromJson(String source) =>
      ShoppingCartItemsModel.fromMap(json.decode(source));

  ShoppingCartItemsModel copyWith({
    String? title,
    double? discountPrize,
    List<String>? images,
    int? selectedItemCount,
    String? id,
    bool? isPaid,
  }) {
    return ShoppingCartItemsModel(
      title: title ?? this.title,
      discountPrize: discountPrize ?? this.discountPrize,
      images: images ?? this.images,
      selectedItemCount: selectedItemCount ?? this.selectedItemCount,
      id: id ?? this.id,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  @override
  String toString() {
    return 'ShoppingCartItemsModel(title: $title, discountPrize: $discountPrize, images: $images, selectedItemCount: $selectedItemCount, id: $id, isPaid: $isPaid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShoppingCartItemsModel &&
        other.title == title &&
        other.discountPrize == discountPrize &&
        listEquals(other.images, images) &&
        other.selectedItemCount == selectedItemCount &&
        other.id == id &&
        other.isPaid == isPaid;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        discountPrize.hashCode ^
        images.hashCode ^
        selectedItemCount.hashCode ^
        id.hashCode ^
        isPaid.hashCode;
  }
}
