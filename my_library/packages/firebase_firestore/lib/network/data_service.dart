import 'package:cloud_firestore/cloud_firestore.dart' as fire_store;
import 'package:firebase_auth/firebase_auth.dart';

abstract class IDataService {
  void initService() {}
  /* MY CATEGORY OPERATIONS */
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    return [{}];
  }

  Future<void> addCategory(
      {required Map<String, dynamic> categoryJson}) async {}
  Future<void> deleteCategory({required String id}) async {}
  Future<void> updateCategory(
      {required Map<String, dynamic> categoryJson}) async {}

  /* MY CARD OPERATIONS */
  Future<List<Map<String, dynamic>>> fetchCards() async {
    return [{}];
  }

  Future<void> addCard({required Map<String, dynamic> cardJson}) async {}
  Future<void> deleteCard({required String id}) async {}
  Future<void> updateCard({required Map<String, dynamic> cardJson}) async {}
}

class DataService implements IDataService {
  User user;
  DataService({required this.user});
  String _pathToCategories = '';
  String _pathToCards = '';

  @override
  void initService() {
    _pathToCards = '/users/' + user.uid + '/cards/';
    _pathToCategories = '/users/' + user.uid + '/categories/';
  }

  @override
  Future<void> addCard({required Map<String, dynamic> cardJson}) async {
    await fire_store.FirebaseFirestore.instance
        .collection(_pathToCards)
        .doc(cardJson['unique_id'])
        .set(cardJson);
  }

  @override
  Future<void> addCategory({required Map<String, dynamic> categoryJson}) async {
    await fire_store.FirebaseFirestore.instance
        .collection(_pathToCategories)
        .doc(categoryJson['unique_id'])
        .set(categoryJson);
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
  Future<void> updateCategory(
      {required Map<String, dynamic> categoryJson}) async {
    await fire_store.FirebaseFirestore.instance
        .collection(_pathToCategories)
        .doc(categoryJson['unique_id'])
        .update(categoryJson);
  }

  @override
  Future<void> updateCard({required Map<String, dynamic> cardJson}) async {
    await fire_store.FirebaseFirestore.instance
        .collection(_pathToCards)
        .doc(cardJson['unique_id'])
        .update(cardJson);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchCards() async {
    List<Map<String, dynamic>> cardsJsonList = [{}];
    final querySnapshot = await fire_store.FirebaseFirestore.instance
        .collection(_pathToCards)
        .get();
    for (var doc in querySnapshot.docs) {
      cardsJsonList.add(doc.data());
    }
    return cardsJsonList;
  }

  @override
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    List<Map<String, dynamic>> categoriesJsonList = [{}];
    final querySnapshot = await fire_store.FirebaseFirestore.instance
        .collection(_pathToCards)
        .get();
    for (var doc in querySnapshot.docs) {
      categoriesJsonList.add(doc.data());
    }
    return categoriesJsonList;
  }
}
