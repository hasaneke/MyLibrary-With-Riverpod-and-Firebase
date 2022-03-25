import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_library/logic/providers/notifiers/cards_notifier.dart';
import 'package:uuid/uuid.dart';

final addCardScreenController =
    ChangeNotifierProvider.autoDispose<AddCardScreenController>((ref) {
  return AddCardScreenController(ref.read);
});

class AddCardScreenController extends ChangeNotifier {
  Reader read;
  AddCardScreenController(this.read);
  final ImagePicker _imagePicker = ImagePicker();
  String containerCatId = '';
  String title = '';
  String shortExp = '';
  String longExp = '';
  List<File> pickedFiles = [];
  List<File> pickedImages = [];
  bool isUploading = false;
  bool isImageClicked = false;

  File? tappedImage;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void undisplayTappedImage() {
    isImageClicked = false;
    notifyListeners();
  }

  void displayTappedImage(File image) {
    isImageClicked = true;
    tappedImage = image;
    notifyListeners();
  }

  Future<void> pickImageWithCamera() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 40,
          maxHeight: 800,
          maxWidth: 400);
      pickedImages = [...pickedImages, File(pickedImage!.path)];
      notifyListeners();
    } on PlatformException catch (e) {
      log(e.code);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> pickImageWithGallery() async {
    final pickedImagesFromGalleryAsXFile = await _imagePicker.pickMultiImage(
        imageQuality: 40, maxHeight: 800, maxWidth: 800);
    List<File> pickedImagesFromGallery = pickedImagesFromGalleryAsXFile!
        .map((e) => File.fromUri(Uri(path: e.path)))
        .toList();
    pickedImages = [...pickedImages, ...pickedImagesFromGallery];
    notifyListeners();
  }

  void removeImage(File imageFile) {
    pickedImages.remove(imageFile);
    notifyListeners();
  }

  Future<void> addCard() async {
    formKey.currentState!.save();
    isUploading = true;
    notifyListeners();
    await read(cardsNotifier.notifier).addCard(values: {
      'id': const Uuid().v1(),
      'containerCatId': containerCatId,
      'title': title,
      'shortExp': shortExp,
      'longExp': longExp
    }, imageFiles: pickedImages);
  }

  void removeFile(File file) {
    log('remove file');
  }
}
