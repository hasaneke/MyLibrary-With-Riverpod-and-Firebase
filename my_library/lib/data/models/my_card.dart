import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MyCard {
  String id;
  String containerCatId;
  String? title;
  String? shortExp;
  String? longExp;
  bool isFavorite;
  DateTime createdAt;
  List<String>? imageUrls = [];

  List<Image>? images = [];
  MyCard({
    required this.id,
    required this.containerCatId,
    required this.createdAt,
    this.title = '',
    this.shortExp = '',
    this.longExp = '',
    this.isFavorite = false,
    this.imageUrls,
  });
  factory MyCard.create({
    required String id,
    required String containerCatId,
    String? title,
    String? shortExp,
    String? longExp,
    List<String>? imageUrls,
  }) {
    return MyCard(
        id: id,
        createdAt: DateTime.now(),
        containerCatId: containerCatId,
        title: title ?? '',
        shortExp: shortExp ?? '',
        longExp: longExp ?? '',
        imageUrls: imageUrls ?? []);
  }
  factory MyCard.fromMap(Map<String, dynamic> map) {
    return MyCard(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      containerCatId: map['container_cat_id'],
      title: map['title'] ?? '',
      shortExp: map['short_Exp'] ?? '',
      longExp: map['long_exp'] ?? '',
      isFavorite: map['is_favorite'],
      imageUrls:
          map['image_urls'] != null ? List<String>.from(map['image_urls']) : [],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toString(),
      'container_cat_id': containerCatId,
      'title': title ?? '',
      'short_exp': shortExp ?? '',
      'long_exp': longExp ?? '',
      'is_favorite': isFavorite,
      'image_urls': imageUrls,
    };
  }

  String toJson() => json.encode(toMap());

  factory MyCard.fromJson(String source) => MyCard.fromMap(json.decode(source));

  Future<void> fetchImages(List<String> imagesUrls) async {}
}
