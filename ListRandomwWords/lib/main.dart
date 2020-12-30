import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(RandomWordsApp());
}

class RandomWordsApp extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Words',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
  
}

class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final _biggerFonst = const TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();
  @override
  Widget build(BuildContext context) {
      return  Scaffold(
        appBar: AppBar(
          title: Text('Random english List words'),
          actions: <Widget>[
            IconButton(icon: Icon(
              Icons.assignment_turned_in
            )
            , onPressed: _pushSaved)
          ],
        ),
      body: _buildSuggestions()
      );
  }
  
  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if (i.isOdd) {
          return Divider();
        }
        if(i >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        final index = i ~/ 2;
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair){
    final alredySaved = _saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase,
      style: _biggerFonst),
      trailing: Icon(
        alredySaved ? Icons.favorite : Icons.favorite_border,
        color: alredySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alredySaved) {
           _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

void _pushSaved(){
  Navigator.push( context,
    MaterialPageRoute(
      builder: (context){
        final tiles = _saved.map((pair){
          return ListTile(
            title: Text(pair.asPascalCase,
            style: _biggerFonst)
          );
        });

        final divided = ListTile.divideTiles(
          context: context,
          tiles: tiles).toList();
        return Scaffold(
          appBar: AppBar(
            title: Text('Palabras guardadas'),
          ),
          body: ListView(
            children: divided,
          ),
        ); 
      }
      )
  );
}
}

