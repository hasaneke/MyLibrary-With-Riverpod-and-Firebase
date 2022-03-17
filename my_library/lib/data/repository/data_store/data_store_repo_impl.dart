import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/data/models/my_category.dart';

abstract class IDataStoreRepository {
  /* MY CATEGORY OPERATIONS */
  Future<List<MyCategory>> fetchCategories() async {
    return [];
  }

  Future<void> addCategory({required MyCategory myCategory}) async {}
  Future<void> deleteCategory({required String id}) async {}
  Future<void> updateCategory({required MyCategory myCategory}) async {}

  /* MY CARD OPERATIONS */
  Future<List<MyCard>> fetchCards() async {
    return [];
  }

  Future<void> addCard({required MyCard myCard}) async {}
  Future<void> deleteCard({required String id}) async {}
  Future<void> updateCard({required MyCard myCard}) async {}
}
