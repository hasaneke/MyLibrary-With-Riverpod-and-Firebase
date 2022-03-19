import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/logic/providers/state_providers/data_providers.dart';
import 'package:my_library/presentation/widgets/my_card_item.dart';

import '../../widgets/my_category_gridview.dart';
import 'components/app_bar/category_detail_appbar.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class CategoryDetailScreen extends HookConsumerWidget {
  MyCategory myCategory;
  CategoryDetailScreen({Key? key, required this.myCategory}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCards = ref
        .read(allCardsProvider)
        .where((card) => card.containerCatId == myCategory.uniqueId)
        .toList();
    final subCategories = ref
        .read(allCategoriesProvider)
        .where((element) => element.containerCatId == myCategory.uniqueId)
        .toList();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryDetailAppbar(myCategory),
            (myCards.isEmpty && subCategories.isEmpty)
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: Text('Empty'),
                    ),
                  )
                : Column(
                    children: [
                      _bodyForCategories(subCategories),
                      Consumer(
                        builder: (context, ref, child) {
                          final myCards = ref
                              .watch(allCardsProvider)
                              .where((card) =>
                                  card.containerCatId ==
                                  myCategory.containerCatId)
                              .toList();
                          return cardListView(myCards);
                        },
                      )
                    ],
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          // ref.read(cardsNotifier.notifier).addCard(
          //     myCard: MyCard(id: 'id2', containerCatId: containerCatId!));
        },
      ),
    );
  }

  ListView cardListView(List<MyCard> myCards) {
    return ListView.builder(
      controller: ScrollController(keepScrollOffset: true),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        var card = myCards.elementAt(index);
        return MyCardItem(card);
      },
      itemCount: myCards.length,
    );
  }

  Widget _bodyForCategories(List<MyCategory> subCategories) {
    return subCategories.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(top: 9),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black54, width: 2)),
              child: Column(
                children: [
                  MyCategoryGridView(containerCatId: myCategory.uniqueId),
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.arrow_upward,
                        color: Colors.black54,
                      ))
                ],
              ),
            ),
          )
        : IconButton(onPressed: () => {}, icon: const Icon(Icons.grid_view));
  }
}
