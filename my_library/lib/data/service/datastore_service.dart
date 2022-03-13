import 'package:my_library/data/models/my_card.dart';

abstract class IDataStoreService {
  /* CATEGORY */
  Future<void> addCategory() async {}
  Future<void> editCategory() async {}
  Future<void> deleteCategory() async {}
  Future<void> moveCategory() async {}
  Future<void> fetchCategories() async {}
  /* CARD */
  Future<void> addCard(MyCard myCard) async {}
  Future<void> editCard() async {}
  Future<void> deleteCard() async {}
  Future<void> moveCard() async {}
  Future<void> clearCards() async {}
  Future<void> fetchCards() async {}
}

class DataStoreService implements IDataStoreService {
  @override
  Future<void> addCard(MyCard myCard) async {}

  @override
  Future<void> addCategory() {
    throw UnimplementedError();
  }

  @override
  Future<void> clearCards() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCard() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory() {
    throw UnimplementedError();
  }

  @override
  Future<void> editCard() {
    throw UnimplementedError();
  }

  @override
  Future<void> editCategory() {
    throw UnimplementedError();
  }

  @override
  Future<void> fetchCards() {
    throw UnimplementedError();
  }

  @override
  Future<void> fetchCategories() {
    throw UnimplementedError();
  }

  @override
  Future<void> moveCard() {
    throw UnimplementedError();
  }

  @override
  Future<void> moveCategory() {
    throw UnimplementedError();
  }
}
