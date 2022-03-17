import 'dart:convert';

class MyCategory {
  String uniqueId;
  String? containerCatId;
  String? title;
  int? colorCode;
  //List<String>? subCategoriesIds;
  MyCategory({
    required this.uniqueId,
    this.containerCatId,
    this.title,
    this.colorCode,
    //this.subCategoriesIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'unique_id': uniqueId,
      'container_cat_id': containerCatId,
      'title': title,
      'color_code': colorCode
      //'sub_categories_ids': subCategoriesIds,
    };
  }

  factory MyCategory.fromMap(Map<String, dynamic> map) {
    return MyCategory(
      uniqueId: map['unique_id'] ?? '',
      containerCatId: map['container_cat_id'],
      title: map['title'],
      colorCode: map['color_code'],
      // subCategoriesIds: map['sub_categories_ids'] != null
      //     ? List<String>.from(map['sub_categories_ids'])
      //     : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyCategory.fromJson(String source) =>
      MyCategory.fromMap(json.decode(source));
}
