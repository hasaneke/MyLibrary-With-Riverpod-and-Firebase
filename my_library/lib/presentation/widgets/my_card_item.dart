import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import 'package:my_library/presentation/widgets/my_app_bar/controller/my_app_bar_controller.dart';
import '../../data/models/my_card.dart';

class MyCardItem extends StatefulHookConsumerWidget {
  MyCard myCard;
  MyCardItem({required this.myCard, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCardItemState();
}

class _MyCardItemState extends ConsumerState<MyCardItem> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    final controller = ref.read(myAppBarController);
    return Consumer(
      builder: (context, ref, child) {
        final isAnyItemLongPressed = ref.watch(
            myAppBarController.select((value) => value.isAnyItemLongPressed));
        return Stack(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              elevation: 5,
              child: ListTile(
                onLongPress: () {
                  if (isAnyItemLongPressed) {
                    setState(() {
                      _isSelected = !_isSelected;
                      controller.addToSelectedCards(uniqueId: widget.myCard.id);
                    });
                  } else {
                    setState(() {
                      _isSelected = !_isSelected;
                      controller.addToSelectedCards(uniqueId: widget.myCard.id);
                      controller.changeAppbar();
                    });
                  }
                },
                onTap: () {
                  if (isAnyItemLongPressed) {
                    setState(() {
                      _isSelected = !_isSelected;
                      controller.addToSelectedCards(uniqueId: widget.myCard.id);
                    });
                  } else {
                    AutoRouter.of(context)
                        .push(CardDetailScreen(myCard: widget.myCard));
                  }
                },
                leading: widget.myCard.imageUrls!.isNotEmpty
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.network(widget.myCard.imageUrls!.first),
                      )
                    : null,
                title: Text(
                  widget.myCard.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: widget.myCard.shortExp != ''
                    ? Text(
                        widget.myCard.shortExp!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    : null,
                trailing: Text(
                  DateFormat.yMMMEd().format(widget.myCard.createdAt),
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
            ),
            isAnyItemLongPressed
                ? Positioned(
                    child: Checkbox(
                        value: _isSelected,
                        onChanged: (value) {
                          setState(() {
                            _isSelected = value!;
                          });
                        },
                        shape: CircleBorder(
                            side: BorderSide(
                          color: Colors.black,
                        ))),
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
