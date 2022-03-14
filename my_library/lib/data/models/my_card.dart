import 'dart:convert';

import 'package:flutter/material.dart';

class MyCard {
  String id;
  String containerCatId;
  String? title;
  String? shortExp;
  String? longExp;
  bool isFavorite;
  List<String>? imageUrls = [];

  List<Image>? images = [];
  MyCard({
    required this.id,
    required this.containerCatId,
    this.title,
    this.shortExp,
    this.longExp,
    this.isFavorite = false,
    this.imageUrls,
  });

  factory MyCard.fromMap(Map<String, dynamic> map) {
    return MyCard(
      id: map['id'],
      containerCatId: map['container_cat_id'],
      title: map['title'],
      shortExp: map['short_Exp'],
      longExp: map['long_exp'],
      isFavorite: map['is_favorite'],
      imageUrls:
          map['image_urls'] != null ? List<String>.from(map['image_urls']) : [],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'container_cat_id': containerCatId,
      'title': title,
      'short_exp': shortExp,
      'long_exp': longExp,
      'is_favorite': isFavorite,
      'image_urls': imageUrls,
    };
  }

  String toJson() => json.encode(toMap());

  factory MyCard.fromJson(String source) => MyCard.fromMap(json.decode(source));

  Future<void> fetchImages(List<String> imagesUrls) async {}
}
