import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/state_providers/data_providers.dart';

class AllCardsScreen extends HookConsumerWidget {
  const AllCardsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: Consumer(
      builder: (context, ref, child) {
        final allCards = ref.watch(allCardsProvider);
        return Column(
          children: allCards
              .map((e) => ListTile(
                    title: Text(
                      e.title!,
                    ),
                    subtitle: Text(e.containerCatId),
                  ))
              .toList(),
        );
      },
    ));
  }
}
