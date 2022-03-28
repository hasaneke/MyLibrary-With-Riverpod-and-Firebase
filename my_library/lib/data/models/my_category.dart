import 'dart:convert';

import 'package:flutter/cupertino.dart';

class MyCategory extends ChangeNotifier {
  String uniqueId;
  String? containerCatId;
  String? title;
  int? colorCode;
  List<String>? subCategoriesIds;
  List<String>? cardsIds;
  MyCategory(
      {required this.uniqueId,
      this.containerCatId,
      this.title,
      this.colorCode,
      this.subCategoriesIds,
      this.cardsIds});

  Map<String, dynamic> toMap() {
    return {
      'unique_id': uniqueId,
      'container_cat_id': containerCatId,
      'title': title,
      'color_code': colorCode,
      'sub_categories_ids': subCategoriesIds,
      'cards_ids': cardsIds
    };
  }

  factory MyCategory.create(
      {required String uniqueId,
      String? containerCatId,
      String? title,
      int? colorCode,
      List<String>? subCategoriesIds,
      List<String>? cardsIds}) {
    return MyCategory(
        uniqueId: uniqueId,
        containerCatId: containerCatId,
        title: title ?? '',
        colorCode: colorCode,
        subCategoriesIds: subCategoriesIds ?? [],
        cardsIds: cardsIds ?? []);
  }
  factory MyCategory.fromMap(Map<String, dynamic> map) {
    return MyCategory(
      uniqueId: map['unique_id'],
      containerCatId: map['container_cat_id'],
      title: map['title'] ?? '',
      colorCode: map['color_code'],
      subCategoriesIds: map['sub_categories_ids'] != null
          ? List<String>.from(map['sub_categories_ids'])
          : [],
      cardsIds:
          map['cards_ids'] != null ? List<String>.from(map['cards_ids']) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyCategory.fromJson(String source) =>
      MyCategory.fromMap(json.decode(source));

  MyCategory copyWith({
    String? uniqueId,
    String? containerCatId,
    String? title,
    int? colorCode,
    List<String>? subCategoriesIds,
    List<String>? cardsIds,
  }) {
    return MyCategory(
        uniqueId: uniqueId ?? this.uniqueId,
        containerCatId: containerCatId ?? this.containerCatId,
        title: title ?? this.title,
        colorCode: colorCode ?? this.colorCode,
        subCategoriesIds: subCategoriesIds ?? this.subCategoriesIds,
        cardsIds: cardsIds ?? this.cardsIds);
  }
}
