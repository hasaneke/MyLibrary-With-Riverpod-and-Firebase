import 'dart:developer';

import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/logic/providers/categories_notifier.dart';
import 'package:riverpod/riverpod.dart';

final favoriteCardsProvider = Provider.autoDispose<List<MyCard>>((ref) {
  List<MyCard> favoriteCards = ref
      .watch(allCardsProvider)
      .where((card) => card.isFavorite == true)
      .toList();
  return favoriteCards;
});
final allCardsProvider = Provider.autoDispose<List<MyCard>>((ref) {
  List<MyCard> allCards = [];
  ref.watch(cardsNotifier).whenData((cards) {
    allCards = cards;
  });
  return allCards;
});
final cardsNotifier =
    StateNotifierProvider.autoDispose<CardsNotifier, AsyncValue<List<MyCard>>>(
        (ref) {
  return CardsNotifier(ref.read);
});

class CardsNotifier extends StateNotifier<AsyncValue<List<MyCard>>> {
  Reader read;

  CardsNotifier(this.read, [AsyncValue<List<MyCard>>? state])
      : super(state ?? const AsyncLoading()) {
    fetchCards();
  }

  Future<void> fetchCards() async {
    try {
      List<MyCard> cards = await read(dataStoreRepository).fetchCards();
      state = AsyncValue.data(cards);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> addCard({required MyCard myCard}) async {
    try {
      await read(dataStoreRepository).addCard(myCard: myCard);
      state = state.whenData((cards) => [...cards, myCard]);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateCard({required MyCard updatedCard}) async {
    try {
      await read(dataStoreRepository).updateCard(myCard: updatedCard);
      state = state.whenData((cards) => cards.map((card) {
            if (card.id == updatedCard.id) {
              return updatedCard;
            }
            return card;
          }).toList());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteCard({required String id}) async {
    try {
      await read(dataStoreRepository).deleteCard(id: id);
      state = state.whenData(
          (cards) => cards.where((element) => element.id != id).toList());
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
