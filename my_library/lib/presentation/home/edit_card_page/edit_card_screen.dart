import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/presentation/home/edit_card_page/controller/edit_card_screen_controller.dart';

class EditCardScreen extends HookConsumerWidget {
  MyCard myCard;
  EditCardScreen({Key? key, required this.myCard}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
                elevation: 0,
                title: Text(
                  'Add Card',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                centerTitle: true,
              ),
              Form(
                key: ref.watch(editCardScreenController(myCard)).formKey,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side: const BorderSide(color: Colors.black54),
                          ),
                          color: Theme.of(context).dialogTheme.backgroundColor,
                          elevation: 4,
                          child: TextFormField(
                            initialValue: ref
                                .watch(editCardScreenController(myCard))
                                .myCard
                                .title,
                            onSaved: (title) {
                              ref
                                  .read(
                                      editCardScreenController(myCard).notifier)
                                  .updateTitle(newTitle: title!);
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: 'title'),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        shortExpWidget(context, ref.read, myCard),
                        const SizedBox(
                          height: 15,
                        ),
                        longExpWidget(context, ref.read, myCard),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Add',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: 17),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Card shortExpWidget(BuildContext context, Reader read, MyCard myCard) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        side: const BorderSide(color: Colors.black54),
      ),
      color: Theme.of(context).dialogTheme.backgroundColor,
      elevation: 4,
      child: TextFormField(
          initialValue: read(editCardScreenController(myCard)).myCard.shortExp,
          onSaved: (shortExp) {
            read(editCardScreenController(myCard).notifier)
                .updateShortExp(newShortExp: shortExp!);
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Short Exp',
          )),
    );
  }

  SizedBox longExpWidget(BuildContext context, Reader read, MyCard myCard) {
    return SizedBox(
      height: 360,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          side: const BorderSide(color: Colors.black54),
        ),
        color: Theme.of(context).dialogTheme.backgroundColor,
        elevation: 4,
        child: TextFormField(
          initialValue: read(editCardScreenController(myCard)).myCard.longExp,
          onSaved: (longExp) {
            read(editCardScreenController(myCard).notifier)
                .updateLongExp(newLongExp: longExp!);
          },
          maxLines: null,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: 'Long Exp'),
        ),
      ),
    );
  }
}
