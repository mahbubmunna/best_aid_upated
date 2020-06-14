import 'package:bestaid/src/models/discussion.dart';
import 'package:flutter/material.dart';

class ReceivedMessagesWidget extends StatelessWidget {
  final Discussion discussion;

  const ReceivedMessagesWidget({
    Key key,
    @required this.discussion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Text(
              "${discussion.replyBy}",
              style: Theme.of(context).textTheme.caption,
            ),*/
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .6),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Text(
                "${discussion.message}",
                style: Theme.of(context).textTheme.body1.apply(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(width: 15),
        Text(
          "${discussion.updatedAt.substring(0,10)}",
          style: Theme.of(context).textTheme.body2.apply(color: Colors.grey),
        ),
      ],
    );
  }
}
