import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/logic/providers/notifiers/cards_notifier.dart';

final myCardDetailScreenController = ChangeNotifierProvider.autoDispose
    .family<MyCardDetailScreenController, MyCard>((ref, myCard) {
  return MyCardDetailScreenController(read: ref.read, myCard: myCard);
});

class MyCardDetailScreenController extends ChangeNotifier {
  Reader read;
  MyCard myCard;
  MyCardDetailScreenController({required this.read, required this.myCard}) {
    initializeImages();
  }

  /*  OTHER VARIABLES */
  List<CachedNetworkImage> images = [];
  CachedNetworkImage? tappedImage;
  bool isImageClicked = false;
  Future<void> initializeImages() async {
    images =
        myCard.imageUrls!.map((e) => CachedNetworkImage(imageUrl: e)).toList();
  }

  /* **************** */
  displayTappedImage(CachedNetworkImage image) {
    isImageClicked = !isImageClicked;

    tappedImage = image;
    notifyListeners();
  }

  deleteFile(String url) {
    log('delete file');
  }

  downloadFile(String downloadUrl, String name) {
    log('download file');
  }

  undisplayTappedImage() {
    isImageClicked = false;

    notifyListeners();
  }

  toggleMark() {
    notifyListeners();
  }

  onPopUpSelected(String choice) async {
    switch (choice) {
      case 'edit':
        log('edit card');
        break;
      case 'delete':
        await read(cardsNotifier.notifier).deleteCard(myCard: myCard);
    }
  }
}
