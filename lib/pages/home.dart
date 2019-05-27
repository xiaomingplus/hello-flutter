import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../constants/colors.dart';

class HomeState extends State<Home> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = Set<WordPair>(); // Add this line.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scuinfo demo'),
        actions: <Widget>[
          // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ], // ... to here.
      ),
      body: _buildList(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            // Add 6 lines from here...
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          ); // ... to here.
        },
      ), // ... to here.
    );
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: /*1*/ (context, i) {
      if (i.isOdd) return Divider(); /*2*/

      final index = i ~/ 2; /*3*/
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10)); /*4*/
      }
      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair); // Add this line.
    final secondStyle = TextStyle(color: SecondColor);
    return Container(
        color: Colors.white,
        child: ListTile(
          title: Container(
              child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(21),
                        child: Image.network(
                          'https://img.scuinfo.com/avatar/man.jpg',
                          height: 42,
                          width: 42,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                      ),
                      Text('某同学·男'),
                    ]),
                    Text('16 hours ago', style: secondStyle)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '人有优良的品质，又有许多劣根性杂糅在一起，好比一块顽铁得火里烧，水里淬，一而再，再而三，又烧又淬，再加千锤百炼，才能把顽铁炼成可铸宝剑的钢材。',
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.more_horiz,
                      color: SecondColor,
                      size: 28.0,
                    ),
                    Row(children: <Widget>[
                      Icon(
                        Icons.chat_bubble_outline,
                        color: SecondColor,
                        size: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                      ),
                      Text('16', style: secondStyle),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: SecondColor,
                        size: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                      ),
                      Text('20', style: secondStyle),
                    ]),
                  ],
                ),
              ),
            ],
          )),

          onTap: () {
            // Add 9 lines from here...
            setState(() {
              if (alreadySaved) {
                _saved.remove(pair);
              } else {
                _saved.add(pair);
              }
            });
          }, // ... to here.
        ));
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}
