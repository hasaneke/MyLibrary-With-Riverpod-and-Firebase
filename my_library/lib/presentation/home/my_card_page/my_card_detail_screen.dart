import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/presentation/home/my_card_page/components/image_item.dart';
import 'package:my_library/presentation/home/my_card_page/components/my_category_detail_screen_app_bar.dart';
import 'package:my_library/presentation/home/my_card_page/components/text_for_card.dart';
import 'package:my_library/presentation/home/my_card_page/controller/my_card_detail_screen_controller.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class CardDetailScreen extends HookConsumerWidget {
  final MyCard myCard;
  const CardDetailScreen({required this.myCard, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(myCardDetailScreenController(myCard));

    log('wotofok');
    return Scaffold(
      body: Stack(children: [
        GestureDetector(
          onTap: () => controller.undisplayTappedImage(),
          child: Consumer(
            builder: (context, ref, child) {
              final isImageClicked = ref.watch(
                  myCardDetailScreenController(myCard)
                      .select((value) => value.isImageClicked));
              log('pü');
              return Opacity(
                opacity: isImageClicked ? 0.45 : 1,
                child: Column(children: [
                  MyCardDetailScreenAppBar(
                      myCard: myCard, controller: controller),
                  myCard.title!.isEmpty &&
                          myCard.shortExp!.isEmpty &&
                          myCard.longExp!.isEmpty
                      ? Consumer(builder: ((context, ref, child) {
                          final images = ref
                              .watch(
                                  myCardDetailScreenController(myCard).notifier)
                              .images;
                          return body1(images, controller);
                        }))
                      : body2(context, controller),
                ]),
              );
            },
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final isImageClicked = ref.watch(
                myCardDetailScreenController(myCard)
                    .select((value) => value.isImageClicked));

            return isImageClicked
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Center(
                      child: InteractiveViewer(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Container(
                            child: controller.tappedImage,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container();
          },
        )
      ]),
    );
  }

  Expanded body1(List<Image> images, MyCardDetailScreenController controller) {
    return Expanded(
      child: images.length > 1
          ? SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: images
                    .map(
                      (image) => ImageWidget(
                          image: image,
                          controller: controller,
                          myCard: myCard), // IMAGE FILE WIDGET
                    )
                    .toList(),
              ),
            )
          : Center(
              child: myCard.imageUrls!.isNotEmpty
                  ? Image.network(myCard.imageUrls!.first)
                  : Container(),
            ),
    );
  }

  Column body2(BuildContext context, MyCardDetailScreenController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        myCard.title!.isNotEmpty ||
                myCard.shortExp!.isNotEmpty ||
                myCard.longExp!.isNotEmpty
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          child: TextForCard(text: myCard.title!),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
        myCard.imageUrls!.isNotEmpty
            ? Center(
                child: SizedBox(
                  height: 250,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final images = ref
                          .watch(myCardDetailScreenController(myCard).notifier)
                          .images;
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: images
                            .map(
                              (image) => ImageWidget(
                                  image: image,
                                  controller: controller,
                                  myCard: myCard),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              )
            : Container(),
        myCard.shortExp!.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  child: TextForCard(
                    text: myCard.shortExp!,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 1)),
                ),
              )
            : Container(),
        myCard.longExp!.isNotEmpty
            ? TextForCard(text: myCard.title!)
            : Container(),
      ],
    );
  }
}