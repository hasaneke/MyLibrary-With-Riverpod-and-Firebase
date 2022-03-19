import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' as fire_store;

abstract class IDataService {
  void initService(String userId) {}
  void disposeService() {}
  /* MY CATEGORY OPERATIONS */
  Future<List<String>> fetchCategories() async {
    return [];
  }

  Future<void> addCategory({required String json}) async {}
  Future<void> deleteCategory({required String id}) async {}
  Future<void> updateCategory({required String json}) async {}

  /* MY CARD OPERATIONS */
  Future<List<String>> fetchCards() async {
    return [];
  }

  Future<void> addCard({required String jsonString}) async {}
  Future<void> deleteCard({required String id}) async {}
  Future<void> updateCard({required String json}) async {}
}

class DataService implements IDataService {
  String _pathToCategories = '';
  String _pathToCards = '';

  @override
  void initService(String userId) {
    _pathToCategories = 'users/' + userId + '/categories/';
    _pathToCards = 'users/' + userId + '/cards/';
  }

  @override
  void disposeService() {}

  @override
  Future<void> addCard({required String jsonString}) async {
    Map<String, dynamic> decodedJson = jsonDecode(jsonString);
    await fire_store.FirebaseFirestore.instance
        .collection(_pathToCards)
        .doc(decodedJson['unique_id'])
        .set(decodedJson);
  }

  @override
  Future<void> addCategory({required String json}) async {
    final Map<String, dynamic> category = jsonDecode(json);
    await fire_store.FirebaseFirestore.instance
        .collection(_pathToCategories)
        .doc(category['unique_id'])
        .set(category);
  }

  @override
  Future<void> deleteCard({required String id}) async {
    await fire_store.FirebaseFirestore.instance
        .collection(_pathToCards)
        .doc(id)
        .delete();
  }

  @override
  Future<void> deleteCategory({required String id}) async {
    await fire_store.FirebaseFirestore.instance
        .collection(_pathToCategories)
        .doc(id)
        .delete();
  }

  @override
  Future<void> updateCategory({required String json}) async {
    final Map<String, dynamic> category = jsonDecode(json);
    await fire_store.FirebaseFirestore.instance
        .collection(_pathToCategories)
        .doc(category['unique_id'])
        .update(jsonDecode(json));
  }

  @override
  Future<void> updateCard({required String json}) async {
    final Map<String, dynamic> card = jsonDecode(json);
    await fire_store.FirebaseFirestore.instance
        .collection(_pathToCards)
        .doc(card['unique_id'])
        .update(jsonDecode(json));
  }

  @override
  Future<List<String>> fetchCards() async {
    List<String> cardsJsonList = [];
    final querySnapshot = await fire_store.FirebaseFirestore.instance
        .collection(_pathToCards)
        .get();

    for (var doc in querySnapshot.docs) {
      cardsJsonList.add(jsonEncode(doc.data()));
    }
    return cardsJsonList;
  }

  @override
  Future<List<String>> fetchCategories() async {
    List<String> categoriesJsonList = [];
    final querySnapshot = await fire_store.FirebaseFirestore.instance
        .collection(_pathToCategories)
        .get();
    for (var doc in querySnapshot.docs) {
      categoriesJsonList.add(jsonEncode(doc.data()));
    }
    return categoriesJsonList;
  }
}
