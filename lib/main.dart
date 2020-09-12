// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:junkaday/authentication/auth.dart';
import 'package:junkaday/introScreens/introScreens.dart';
import 'package:junkaday/mainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Junkaday',
        theme: ThemeData(primaryColor: Colors.cyan),
        home: MainApp());
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    AuthService.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {}
    });
    AuthService.googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return IntroScreens(introScreenNumber: 1);
    } else {
      return MainPage();
    }
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
