import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/state_providers/data_providers.dart';
import 'package:my_library/presentation/widgets/my_app_bar/my_app_bar.dart';
import 'package:my_library/presentation/widgets/my_card_item.dart';

class AllCardsScreen extends HookConsumerWidget {
  const AllCardsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: MyAppBar(
          title: FaIcon(
            FontAwesomeIcons.list,
            color: Theme.of(context).iconTheme.color,
            size: 45,
          ),
          centerTitle: true,
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final allCards = ref.watch(allCardsProvider);
            return Column(
              children: allCards
                  .map((e) => MyCardItem(
                        myCard: e,
                      ))
                  .toList(),
            );
          },
        ));
  }
}
