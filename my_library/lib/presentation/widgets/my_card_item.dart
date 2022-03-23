import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/my_card.dart';

// ignore: must_be_immutable
class MyCardItem extends StatelessWidget {
  MyCard myCard;
  MyCardItem(this.myCard);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 5,
      child: ListTile(
        leading: myCard.imageUrls!.isNotEmpty
            ? CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(myCard.imageUrls!.first),
              )
            : null,
        title: Text(
          myCard.title!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        subtitle: myCard.shortExp != ''
            ? Text(
                myCard.shortExp!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
        trailing: Text(
          DateFormat.yMMMEd().format(myCard.createdAt),
          style: Theme.of(context).textTheme.overline,
        ),
      ),
    );
  }
}
