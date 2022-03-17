import 'package:flutter/material.dart';
import '../../data/models/my_card.dart';

// ignore: must_be_immutable
class MyCardItem extends StatelessWidget {
  MyCard myCard;
  // ignore: use_key_in_widget_constructors
  MyCardItem(this.myCard);

  @override
  Widget build(BuildContext context) {
    //var myCard = Get.put(myCard, tag: myCard.path);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 5,
      child: ListTile(
        title: Text(
          myCard.title!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          //   style: context.textTheme.bodyText2,
        ),
        subtitle: myCard.shortExp != ''
            ? Text(
                myCard.shortExp!,
                overflow: TextOverflow.ellipsis,
                //style: context.textTheme.subtitle1,
              )
            : null,
        // trailing: Text(
        //   DateFormat.yMMMEd().format(myCard.date),
        //   //style: context.textTheme.overline,
        // ),
      ),
    );
  }
}
