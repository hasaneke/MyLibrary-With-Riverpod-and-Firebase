import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/presentation/widgets/my_app_bar/controller/my_app_bar_controller.dart';
import '../../data/models/my_card.dart';

class MyCardItem extends ConsumerWidget {
  final MyCard myCard;
  const MyCardItem({Key? key, required this.myCard}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(myAppBarController);
    return Consumer(
      builder: (context, ref, child) {
        final isAnyItemLongPressed = ref.watch(
            myAppBarController.select((value) => value.isAnyItemLongPressed));
        final isSelected = ref.watch(myAppBarController
            .select((value) => value.selectedCards.contains(myCard)));

        return Stack(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              elevation: 5,
              child: ListTile(
                selectedTileColor: const Color.fromARGB(255, 211, 195, 195),
                selected: isSelected,
                onLongPress: () {
                  if (isAnyItemLongPressed) {
                    controller.putInSelectedCardsList(card: myCard);
                  } else {
                    controller.changeAppbar();
                    controller.putInSelectedCardsList(card: myCard);
                  }
                },
                onTap: () {
                  if (isAnyItemLongPressed) {
                    controller.putInSelectedCardsList(card: myCard);
                  } else {
                    AutoRouter.of(context)
                        .push(CardDetailScreen(myCard: myCard));
                  }
                },
                leading: myCard.imageUrls!.isNotEmpty
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        child: CachedNetworkImage(
                            imageUrl: myCard.imageUrls!.first),
                      )
                    : null,
                title: Text(
                  myCard.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: myCard.shortExp != ''
                    ? Text(
                        myCard.shortExp!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    : null,
                trailing: Text(
                  DateFormat.yMMMEd().format(myCard.createdAt),
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
            ),
            isAnyItemLongPressed
                ? Positioned(
                    child: Checkbox(
                      value: isSelected,
                      onChanged: (value) {},
                      shape: const CircleBorder(
                          side: BorderSide(
                        color: Colors.black,
                      )),
                    ),
                    top: 0,
                    left: 0,
                  )
                : Container()
          ],
        );
      },
    );
  }
}
