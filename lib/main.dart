import 'package:flutter/material.dart';
import 'package:gestion_jeu_de_societe/BoardGameAdd.dart';
import 'package:gestion_jeu_de_societe/BoardGameModel.dart';
import 'package:image_picker/image_picker.dart';

import 'DataBaseProvider.dart';

import 'dart:io';

import 'dart:async';

import 'dart:convert';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget boardGameCard(BoardGame boardGame) {
    return Card(
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text('Nom : '+boardGame.nom), Text('Auteur : '+boardGame.editeur)],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text('De '+boardGame.nbrJoueurMin.toString()+' à '+boardGame.nbrJoueurMax.toString()+' joueurs')],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Image.memory(base64Decode(boardGame.photo))],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tous mes jeux de société")),
      body: FutureBuilder<List<BoardGame>>(
        future: DBProvider.db.getAllBoardGames(),
        builder:
            (BuildContext context, AsyncSnapshot<List<BoardGame>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                BoardGame item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBProvider.db.deleteBoardGame(item.id);
                  },
                  child: boardGameCard(item)
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BoardGameAdd(
                        title: 'Ajouter un jeu de société',
                      )));
        },
      ),
    );
  }
}
