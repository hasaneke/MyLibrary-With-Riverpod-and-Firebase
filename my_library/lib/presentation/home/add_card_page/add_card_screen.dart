import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:my_library/presentation/home/add_card_page/controller/add_card_sceen_controller.dart';

class AddCardScreen extends HookConsumerWidget {
  final String containerCatId;

  const AddCardScreen({required this.containerCatId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final functionController = ref.read(addCardScreenController);
    Size size = MediaQuery.of(context).size;

    return Scaffold(body: Consumer(
      builder: (context, ref, child) {
        final screenController = ref.watch(addCardScreenController);
        screenController.containerCatId = containerCatId;
        return screenController.isUploading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(color: Colors.black),
                    Text('It is uploading...'),
                  ],
                ),
              )
            : Stack(children: [
                GestureDetector(
                  onTap: functionController.undisplayTappedImage,
                  child: Opacity(
                    opacity: screenController.isImageClicked ? 0.4 : 1,
                    child: SingleChildScrollView(
                      physics: screenController.isImageClicked
                          ? const NeverScrollableScrollPhysics()
                          : null,
                      child: Column(
                        children: [
                          AppBar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            foregroundColor:
                                Theme.of(context).appBarTheme.foregroundColor,
                            elevation: 0,
                            title: Text(
                              'Edit Card',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color),
                            ),
                            centerTitle: true,
                          ),
                          Form(
                            key: screenController.formKey,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        side: const BorderSide(
                                            color: Colors.black54),
                                      ),
                                      color: Theme.of(context)
                                          .dialogTheme
                                          .backgroundColor,
                                      elevation: 4,
                                      child: TextFormField(
                                        enabled:
                                            !screenController.isImageClicked,
                                        onSaved: (title) {
                                          screenController.title = title!;
                                        },
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'title'),
                                      ),
                                    ),
                                    pickFilesOptions(functionController),
                                    screenController.pickedImages.isEmpty
                                        ? Container()
                                        : imageItem(screenController,
                                            functionController),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    shortExpWidget(context, screenController),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    longExpWidget(context, screenController),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    screenController.isUploading
                                        ? const CircularProgressIndicator()
                                        : ElevatedButton(
                                            onPressed:
                                                screenController.isUploading
                                                    ? null
                                                    : () async {
                                                        await functionController
                                                            .addCard();
                                                        AutoRouter.of(context)
                                                            .pop();
                                                      },
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
                    ),
                  ),
                ),
                screenController.isImageClicked
                    ? Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            top: 0,
                            child: Center(
                              child: InteractiveViewer(
                                child: SizedBox(
                                  height: size.height * 0.6,
                                  width: size.width * 0.7,
                                  child:
                                      Image.file(screenController.tappedImage!),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ]);
      },
    ));
  }

  SizedBox longExpWidget(
      BuildContext context, AddCardScreenController screenController) {
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
          enabled: !screenController.isImageClicked,
          onSaved: (longExp) {
            screenController.longExp = longExp!;
          },
          maxLines: null,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: 'Long Exp'),
        ),
      ),
    );
  }

  Card shortExpWidget(
      BuildContext context, AddCardScreenController screenController) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        side: const BorderSide(color: Colors.black54),
      ),
      color: Theme.of(context).dialogTheme.backgroundColor,
      elevation: 4,
      child: TextFormField(
          enabled: !screenController.isImageClicked,
          onSaved: (shortExp) {
            screenController.shortExp = shortExp!;
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Short Exp',
          )),
    );
  }

  SizedBox imageItem(AddCardScreenController screenController,
      AddCardScreenController functionController) {
    return SizedBox(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: screenController.pickedImages
            .map((imageFile) => Row(
                  children: [
                    Stack(children: [
                      InkWell(
                        onTap: () =>
                            functionController.displayTappedImage(imageFile),
                        child: SizedBox(
                          height: 250,
                          child: Image.file(imageFile),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                            onPressed: screenController.isUploading
                                ? null
                                : () =>
                                    functionController.removeImage(imageFile),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                            )),
                      ),
                      // Positioned(
                      //   child: IconButton(
                      //       onPressed: () {},
                      //       icon: const Icon(
                      //         Icons.download,
                      //         color: Colors.red,
                      //         size: 25,
                      //       )),
                      //   bottom: 0,
                      //   right: 0,
                      // )
                    ]),
                    const SizedBox(
                      width: 9,
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }

  Padding pickFilesOptions(AddCardScreenController functionController) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: functionController.pickImageWithCamera,
              icon: const FaIcon(
                FontAwesomeIcons.camera,
                size: 30,
              )),
          IconButton(
            onPressed: functionController.pickImageWithGallery,
            icon: const Icon(
              Icons.photo_album,
              size: 35,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.fileArrowUp,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
