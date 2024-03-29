import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_library/presentation/home/my_card_page/controller/my_card_detail_screen_controller.dart';
import 'package:my_library/presentation/widgets/move_dialog/move_dialog.dart';
import 'package:my_library/product/models/my_card.dart';
import 'package:my_library/product/navigator/route.gr.dart';
import 'package:my_library/product/widgets/move_dialog/constants/pop_up_menu_constants.dart';

class MyCardDetailScreenAppBar extends StatelessWidget {
  const MyCardDetailScreenAppBar({
    Key? key,
    required this.myCard,
    required this.controller,
  }) : super(key: key);

  final MyCard myCard;
  final MyCardDetailScreenController controller;

  @override
  Widget build(BuildContext context) {
    bool isMarked = myCard.isMarked;
    return Container(
      height: AppBar().preferredSize.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  DateFormat.yMMMEd().format(myCard.createdAt),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          Row(
            children: [
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setMarked) {
                return IconButton(
                    onPressed: () {
                      controller.toggleMark();
                      setMarked(() => isMarked = !isMarked);
                    },
                    icon: isMarked
                        ? const Icon(Icons.bookmark)
                        : const Icon(Icons.bookmark_border));
              }),
              PopupMenuButton<String>(
                enabled: !controller.isImageClicked,
                onSelected: (choice) async {
                  await controller.onPopUpSelected(choice);
                  switch (choice) {
                    case 'delete':
                      AutoRouter.of(context).pop();
                      break;
                    case 'edit':
                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //   content: Text('Not in service right now'),
                      //   duration: Duration(seconds: 2),
                      // ));
                      AutoRouter.of(context)
                          .push(EditCardScreen(myCard: myCard));
                      break;
                    case 'move':
                      showDialog(
                          context: context, builder: (_) => const MoveDialog());
                      break;
                  }
                },
                itemBuilder: (context) => PopUpMenuConstants.choices
                    .map((choice) => PopupMenuItem<String>(
                        value: choice, child: Text(choice)))
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
