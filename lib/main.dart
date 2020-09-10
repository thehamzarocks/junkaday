// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Junkaday',
        theme: ThemeData(primaryColor: Colors.cyan),
        home: IntroScreens(introScreenNumber: 1));
  }
}

class IntroScreenDetails {
  IntroScreenDetails(int number, String text, IconData icon) {
    this.number = number;
    this.text = text;
    this.icon = icon;
  }
  int number;
  String text;
  IconData icon;
}

class IntroScreens extends StatelessWidget {
  IntroScreens({Key key, this.introScreenNumber}) : super(key: key);

  final int introScreenNumber;

  final Map<int, IntroScreenDetails> introScreenMapping = {
    1: IntroScreenDetails(1, 'Eating Junk? Tell Us!', Icons.local_pizza_outlined),
    2: IntroScreenDetails(2, 'Log Units of Junk Consumed, and Earn Quirky Rewards', Icons.cake),
    3: IntroScreenDetails(3, 'Check on your Friends, try not to have the most Frownys', Icons.fastfood_outlined),
  };

  void _navigate(BuildContext context) {
    final int nextIntroScreen = (introScreenNumber) % 3 + 1;
    Navigator.push(context, MaterialPageRoute(builder: (context) => IntroScreens(introScreenNumber: nextIntroScreen)));
  }

  @override
  Widget build(BuildContext context) {
    IntroScreenDetails currentIntroScreenDetails =
        introScreenMapping[introScreenNumber];
    return GestureDetector(
        onTap: () => _navigate(context),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (Padding(
                  child: Icon(currentIntroScreenDetails.icon,
                      color: Theme.of(context).primaryColor, size: 200),
                  padding: EdgeInsets.all(30.0))),
              (Padding(
                padding: EdgeInsets.all(30.0),
                child:(Text(currentIntroScreenDetails.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Futura',
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.none)))))
            ]));
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _savedSuggestions = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Junk a Day'),
          actions: [IconButton(icon: Icon(Icons.list), onPressed: _showSaved)],
        ),
        body: _buildSuggestions());
  }

  void _showSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext buildContext) {
      final tiles = _savedSuggestions.map((WordPair pair) {
        return ListTile(title: Text(pair.asPascalCase, style: _biggerFont));
      });
      final divided =
          ListTile.divideTiles(tiles: tiles, context: buildContext).toList();
      return Scaffold(
          appBar: AppBar(
            title: Text('Favorited Junk'),
          ),
          body: ListView(children: divided));
    }));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider();
          }
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair wordPair) {
    final alreadySaved = _savedSuggestions.contains(wordPair);
    return ListTile(
      title: Text(wordPair.asPascalCase, style: _biggerFont),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedSuggestions.remove(wordPair);
          } else {
            _savedSuggestions.add(wordPair);
          }
        });
      },
    );
  }
}
