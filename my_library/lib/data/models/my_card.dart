import 'dart:convert';

import 'package:flutter/material.dart';

class MyCard {
  String id;
  String containerCatId;
  String? title;
  String? shortExp;
  String? longExp;
  bool isMarked;
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
    this.isMarked = false,
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
      shortExp: map['short_exp'] ?? '',
      longExp: map['long_exp'] ?? '',
      isMarked: map['is_marked'],
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
      'is_marked': isMarked,
      'image_urls': imageUrls,
    };
  }

  String toJson() => json.encode(toMap());

  factory MyCard.fromJson(String source) => MyCard.fromMap(json.decode(source));

  Future<void> fetchImages(List<String> imagesUrls) async {}

  MyCard copyWith({
    String? id,
    String? containerCatId,
    String? title,
    String? shortExp,
    String? longExp,
    bool? isMarked,
    DateTime? createdAt,
    List<String>? imageUrls,
    List<Image>? images,
  }) {
    return MyCard(
      id: id ?? this.id,
      containerCatId: containerCatId ?? this.containerCatId,
      title: title ?? this.title,
      shortExp: shortExp ?? this.shortExp,
      longExp: longExp ?? this.longExp,
      isMarked: isMarked ?? this.isMarked,
      createdAt: createdAt ?? this.createdAt,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}
