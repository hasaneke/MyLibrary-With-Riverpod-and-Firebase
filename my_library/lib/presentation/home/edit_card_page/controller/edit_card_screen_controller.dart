import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_library/logic/providers/notifiers/cards_notifier.dart';
import 'package:my_library/product/models/my_card.dart';

enum EditStatus { initial, uploading, failed, success }

final editCardScreenController = StateNotifierProvider.family<
    EditCardScreenController, EditCardState, MyCard>((ref, card) {
  return EditCardScreenController(EditCardState(card), ref.read);
});

class EditCardScreenController extends StateNotifier<EditCardState> {
  Reader read;

  EditCardScreenController(EditCardState state, this.read)
      : super(
          state,
        );

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImageWithCamera() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 100,
          maxHeight: 800,
          maxWidth: 400);
      state = state.copyWith(
          pickedImages: [...state.pickedImages!, File(pickedImage!.path)]);
    } on PlatformException catch (e) {
      log(e.code);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> pickImageWithGallery() async {
    final pickedImagesFromGalleryAsXFile = await _imagePicker.pickMultiImage(
        imageQuality: 100, maxHeight: 800, maxWidth: 800);
    List<File> pickedImagesFromGallery = pickedImagesFromGalleryAsXFile!
        .map((e) => File.fromUri(Uri(path: e.path)))
        .toList();
    state = state.copyWith(
        pickedImages: [...state.pickedImages!, ...pickedImagesFromGallery]);
  }

  void updateTitle({required String newTitle}) {
    state = state.copyWith(myCard: state.myCard.copyWith(title: newTitle));
  }

  void updateShortExp({required String newShortExp}) {
    state =
        state.copyWith(myCard: state.myCard.copyWith(shortExp: newShortExp));
  }

  void updateLongExp({required String newLongExp}) {
    state = state.copyWith(myCard: state.myCard.copyWith(longExp: newLongExp));
  }

  Future<void> removeImageFile({required File file}) async {
    state = state.copyWith(
        pickedImages:
            state.pickedImages!.where((element) => element != file).toList());
  }

  Future<void> removeCachedImage({required String imageUrl}) async {
    state = state.copyWith(
        myCard: state.myCard.copyWith(
            imageUrls: state.myCard.imageUrls!
                .where((element) => element != imageUrl)
                .toList()));
  }

  Future<void> updateCard() async {
    state.formKey!.currentState!.save();
    state = state.copyWith(status: EditStatus.uploading);
    try {
      await read(cardsNotifier.notifier).updateCard(updatedCard: state.myCard);
    } catch (e) {
      state = state.copyWith(status: EditStatus.failed);
    }
  }
}

class EditCardState {
  MyCard myCard;
  List<File>? pickedImages = [];
  GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  EditStatus? status = EditStatus.initial;
  EditCardState(this.myCard, [this.pickedImages, this.formKey, this.status]);

  EditCardState copyWith({
    MyCard? myCard,
    List<File>? pickedImages,
    GlobalKey<FormState>? formKey,
    EditStatus? status,
  }) {
    return EditCardState(
      myCard ?? this.myCard,
      pickedImages ?? this.pickedImages,
      formKey ?? this.formKey,
      status ?? this.status,
    );
  }
}
