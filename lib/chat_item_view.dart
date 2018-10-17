import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatItemView extends StatelessWidget {
  final ChatItemViewState viewState;

  const ChatItemView(this.viewState);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              createAvatar(),
              createMiddleWidgets(),
              createTrailingWidgets(),
            ],
          ),
        ),
      );

  Widget createAvatar() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        radius: 28.0,
        child: FlutterLogo(),
      ),
    );
  }

  Widget createMiddleWidgets() {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 4.0,
                bottom: 2.0,
              ),
              child: Text(
                viewState.name,
                maxLines: 1,
                style: Styles.UserName,
              ),
            ),
            Text(
              viewState.summary,
              maxLines: 2,
              style: Styles.Summary,
            ),
          ],
        ),
      ),
    );
  }

  Widget createTrailingWidgets() {
    if (viewState.unreadMessages == 0) {
      return Column(
        children: <Widget>[
          timestampText(),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          timestampText(),
          unreadMessages(),
        ],
      );
    }
  }

  Widget timestampText() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        viewState.timestamp,
        style: Styles.Timestamp,
      ),
    );
  }

  Widget unreadMessages() => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: CircleAvatar(
          backgroundColor: CupertinoColors.activeBlue,
          radius: 10.0,
          child: Text(
            "${viewState.unreadMessages}",
            style: Styles.UnreadMessages,
          ),
        ),
      );
}

abstract class Styles {
  static const UserName = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
  );
  static const Summary = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    color: CupertinoColors.inactiveGray,
  );
  static const Timestamp = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: CupertinoColors.inactiveGray,
  );
  static const UnreadMessages = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: CupertinoColors.white,
  );
}

class ChatItemViewState {
  // TODO: add avatar
  final String name;
  final String summary;
  final String timestamp;
  final int unreadMessages;

  ChatItemViewState(this.name, this.summary, this.timestamp, this.unreadMessages);
}
