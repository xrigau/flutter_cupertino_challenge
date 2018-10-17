import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_challenge/chat_item_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const int ITEM_COUNT = 100;

  final List<Tab> _tabs = [
    Tab("Contacts", CupertinoIcons.person),
    Tab("Calls", CupertinoIcons.phone),
    Tab("Post", CupertinoIcons.photo_camera),
    Tab("Chats", CupertinoIcons.conversation_bubble),
    Tab("Settings", CupertinoIcons.settings),
  ];

  final List<ChatItemViewState> _viewStates = generateViewStates();

  static List<ChatItemViewState> generateViewStates() {
    return nouns
        .take(ITEM_COUNT)
        .map((noun) => ChatItemViewState(
              "${generateWordPairs().take(1).first.asPascalCase} ${generateWordPairs().take(1).first.asPascalCase}",
              "${generateWordPairs().take(1).first.asPascalCase}${generateWordPairs().take(3).fold("", (String acc, WordPair pair) => "$acc ${pair.asString}")}",
              "${Random().nextInt(24)}:${Random().nextInt(60)}",
              Random().nextBool() ? Random().nextInt(10) : 0,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _tabs.map(_createTabView).toList(),
      ),
      tabBuilder: (BuildContext context, int index) => Container(
            color: CupertinoColors.white,
            child: Column(
              children: <Widget>[
                createNavigationBar(_tabs[index]),
                createPageView(_tabs[index]),
              ],
            ),
          ),
    );
  }

  Widget createPageView(Tab tab) {
    return Flexible(
      child: ListView.builder(
        itemBuilder: createItemView,
        itemCount: _viewStates.length,
      ),
    );
  }

  Widget createItemView(BuildContext context, int index) => Container(
        child: ChatItemView(_viewStates[index]),
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(
              color: CupertinoColors.lightBackgroundGray,
            ),
          ),
        ),
      );

  CupertinoNavigationBar createNavigationBar(Tab tab) {
    return CupertinoNavigationBar(
      middle: Text(tab.title),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Edit'),
      ),
    );
  }

  BottomNavigationBarItem _createTabView(tab) => BottomNavigationBarItem(
        icon: Icon(tab.icon),
        title: Text(tab.title),
      );
}

class Tab {
  final String title;
  final IconData icon;
  Tab(this.title, this.icon);
}
