import 'dart:convert';

class MyCategory {
  String uniqueId;
  String? containerCatId;
  String? title;
  List<String>? subCategoriesIds;
  MyCategory({
    required this.uniqueId,
    this.containerCatId,
    this.title,
    this.subCategoriesIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'unique_id': uniqueId,
      'container_cat_id': containerCatId,
      'title': title,
      'sub_categories_ids': subCategoriesIds,
    };
  }

  factory MyCategory.fromMap(Map<String, dynamic> map) {
    return MyCategory(
      uniqueId: map['unique_id'] ?? '',
      containerCatId: map['container_cat_id'],
      title: map['title'],
      subCategoriesIds: map['sub_categories_ids'] != null
          ? List<String>.from(map['sub_categories_ids'])
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyCategory.fromJson(String source) =>
      MyCategory.fromMap(json.decode(source));
}
