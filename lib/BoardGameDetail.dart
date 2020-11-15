import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_jeu_de_societe/BoardGameModel.dart';

class BoardGameDetail extends StatefulWidget {
  BoardGameDetail({this.boardGame});

  final BoardGame boardGame;

  @override
  _BoardGameDetailState createState() => _BoardGameDetailState();
}

class _BoardGameDetailState extends State<BoardGameDetail> {
  @override
  Widget build(BuildContext context) {
    String _cooperatif;
    if (widget.boardGame.coop == 0) {
      _cooperatif = "Jeu compétitif";
    } else {
      _cooperatif = "Jeu coopératif";
    }

    return Scaffold(
      appBar: AppBar(title: Text("Détails du jeu")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.boardGame.nom),
              Image.memory(base64Decode(widget.boardGame.photo))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("De " +
                  widget.boardGame.nbrJoueurMin.toString() +
                  " à " +
                  widget.boardGame.nbrJoueurMax.toString() +
                  " joueurs"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Editeur : " + widget.boardGame.editeur),
              Text("Auteur : " + widget.boardGame.auteur),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Genre : " + widget.boardGame.genre),
              Text("A partir de " + widget.boardGame.age.toString() + " ans"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Type de jeu : " + widget.boardGame.type),
              Text("Description : " + widget.boardGame.descritpion),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(_cooperatif),
            ],
          ),
        ],
      ),
    );
  }
}
