import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/state_providers/data_providers.dart';
import 'package:my_library/presentation/widgets/my_app_bar/my_app_bar.dart';
import 'package:my_library/presentation/widgets/my_card_item.dart';

// ignore: use_key_in_widget_constructors
class MarkedCardsScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: MyAppBar(
          title: Icon(
            Icons.bookmark,
            color: Theme.of(context).iconTheme.color,
            size: 45,
          ),
          centerTitle: true,
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final markedCards = ref.watch(markedCardsProvider);
            return ListView.builder(
              controller: ScrollController(keepScrollOffset: true),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return MyCardItem(
                  myCard: markedCards[index],
                );
              },
              itemCount: markedCards.length,
            );
          },
        ));
  }
}
