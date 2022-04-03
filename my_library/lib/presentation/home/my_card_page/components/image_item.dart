import 'package:flutter/material.dart';
import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/presentation/home/my_card_page/controller/my_card_detail_screen_controller.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.image,
    required this.controller,
    required this.myCard,
  }) : super(key: key);
  final Image image;
  final MyCard myCard;
  final MyCardDetailScreenController controller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          const SizedBox(
            width: 6,
          ),
          SizedBox(height: 250, child: image),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
