import 'package:data_service/network/data_service.dart';
import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/data/repository/data_store/data_store_repo_impl.dart';

class DataStoreRepository implements IDataStoreRepository {
  DataService dataService;
  DataStoreRepository({required this.dataService});

  @override
  Future<void> addCard({required MyCard myCard}) async {
    await dataService.addCard(cardJson: myCard.toMap());
  }

  @override
  Future<void> addCategory({required MyCategory myCategory}) async {
    await dataService.addCategory(categoryJson: myCategory.toMap());
  }

  @override
  Future<void> deleteCard({required String id}) async {
    await dataService.deleteCard(id: id);
  }

  @override
  Future<void> deleteCategory({required String id}) async {
    await dataService.deleteCategory(id: id);
  }

  @override
  Future<List<MyCard>> fetchCards() async {
    List<Map<String, dynamic>> jsonDataList = await dataService.fetchCards();
    List<MyCard> fetchedCards = [];
    for (var doc in jsonDataList) {
      fetchedCards.add(MyCard.fromMap(doc));
    }
    return fetchedCards;
  }

  @override
  Future<List<MyCategory>> fetchCategories() async {
    List<Map<String, dynamic>> jsonDataList =
        await dataService.fetchCategories();
    List<MyCategory> fetchedCategories = [];
    for (var doc in jsonDataList) {
      fetchedCategories.add(MyCategory.fromMap(doc));
    }
    return fetchedCategories;
  }

  @override
  Future<void> updateCard({required MyCard myCard}) async {
    await dataService.updateCard(cardJson: myCard.toMap());
  }

  @override
  Future<void> updateCategory({required MyCategory myCategory}) async {
    await dataService.updateCategory(categoryJson: myCategory.toMap());
  }
}
