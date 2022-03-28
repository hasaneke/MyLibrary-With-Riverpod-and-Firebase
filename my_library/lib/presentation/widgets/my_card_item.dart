import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_library/logic/navigation/route.gr.dart';
import '../../data/models/my_card.dart';

class MyCardItem extends StatelessWidget {
  final MyCard myCard;
  final Function onLongPressed;
  const MyCardItem(
      {required this.myCard, required this.onLongPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 5,
      child: ListTile(
        onLongPress: () => onLongPressed,
        onTap: () =>
            AutoRouter.of(context).push(CardDetailScreen(myCard: myCard)),
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
          style: Theme.of(context).textTheme.titleSmall,
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
