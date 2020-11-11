import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_jeu_de_societe/main.dart';

import 'BoardGameModel.dart';
import 'DataBaseProvider.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'dart:async';

class BoardGameAdd extends StatelessWidget {
  BoardGameAdd({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DisplayBoardGameAdd(title: title),
    );
  }
}

class DisplayBoardGameAdd extends StatefulWidget {
  DisplayBoardGameAdd({this.title});

  final String title;

  @override
  _DisplayBoardGameAddState createState() => _DisplayBoardGameAddState();
}

class _DisplayBoardGameAddState extends State<DisplayBoardGameAdd> {
  Widget boutonRetour() {
    return RaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: const Text('Retour', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget boutonAjouterPhoto() {
    return RaisedButton(
      onPressed: () {
        getImage();
      },
      child: Icon(Icons.add_a_photo),
    );
  }

  Widget boutonValider() {
    return RaisedButton(
      onPressed: () async {
        BoardGame jds = BoardGame();
        jds.nom = _nom;
        jds.genre = _genre;
        _choixSwitch ? jds.coop = 1 : jds.coop = 0;
        jds.nbrJoueurMin = _nbrMin;
        jds.nbrJoueurMax = _nbrMax;
        jds.age = _age;
        jds.type = _type;
        jds.editeur = _editeur;
        jds.auteur = _auteur;
        jds.descritpion = _description;
        List<int> imageBytes = _image.readAsBytesSync();
        String photoBase64 = base64Encode(imageBytes);
        jds.photo = photoBase64;
        await DBProvider.db.newBoardGame(jds);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: const Text('Valider', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  String _nom;
  String _genre;
  int _nbrMin;
  int _nbrMax;
  int _age;
  String _type;
  String _editeur;
  String _auteur;
  String _description;
  bool _choixSwitch = false;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,maxHeight:  200 , maxWidth: 200 );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SingleChildScrollView(
                /*height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.9,*/
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Nom du jeu :'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Exemple : 7 wonders',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _nom = value;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text('Genre du jeu :'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Exemple : Draft, Placement d\'ouvriers...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _genre = value;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text('Jeu coopératif :'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Switch(
                            value: _choixSwitch,
                            activeColor: Colors.green,
                            activeTrackColor: Colors.amber,
                            inactiveTrackColor: Colors.red[200],
                            inactiveThumbColor: Colors.red,
                            onChanged: (value) {
                              setState(() {
                                _choixSwitch = value;
                              });
                            }),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text('Nombre minimum de joueurs :'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Exemple : 1',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _nbrMin = int.parse(value);
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text('Nombre maximum de joueurs :'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Exemple : 6',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _nbrMax = int.parse(value);
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text('Age minimum :'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Exemple : 12',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _age = int.parse(value);
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text('Type du jeu :'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Exemple : Familial, Expert, Ambiance...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text('Editeur du jeu :'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Exemple : Intrafin, Space Cowboys...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _editeur = value;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text('Auteur du jeu :'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Exemple : Antoine Bauza, Bruno Cathala...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _auteur = value;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text('Description du jeu :'),
                    TextField(
                      decoration: InputDecoration(
                        hintText:
                            'Exemple : Jeu à thème fort, Bon pour 3 joueurs...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _description = value;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text('Photo du jeu :'),
                    Center(
                      child: _image == null
                          ? Text('Pas de photo')
                          : Image.file(_image),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        boutonRetour(),
                        boutonAjouterPhoto(),
                        boutonValider()
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
