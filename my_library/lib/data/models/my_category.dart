import 'dart:convert';

import 'package:flutter/cupertino.dart';

class MyCategory extends ChangeNotifier {
  String uniqueId;
  String? containerCatId;
  String? title;
  int? colorCode;

  MyCategory({
    required this.uniqueId,
    this.containerCatId,
    this.title,
    this.colorCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'unique_id': uniqueId,
      'container_cat_id': containerCatId,
      'title': title,
      'color_code': colorCode,
    };
  }

  factory MyCategory.create({
    required String uniqueId,
    String? containerCatId,
    String? title,
    int? colorCode,
  }) {
    return MyCategory(
      uniqueId: uniqueId,
      containerCatId: containerCatId,
      title: title ?? '',
      colorCode: colorCode,
    );
  }
  factory MyCategory.fromMap(Map<String, dynamic> map) {
    return MyCategory(
      uniqueId: map['unique_id'],
      containerCatId: map['container_cat_id'],
      title: map['title'] ?? '',
      colorCode: map['color_code'],
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
  }) {
    return MyCategory(
      uniqueId: uniqueId ?? this.uniqueId,
      containerCatId: containerCatId ?? this.containerCatId,
      title: title ?? this.title,
      colorCode: colorCode ?? this.colorCode,
    );
  }
}
