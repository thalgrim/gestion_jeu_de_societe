import 'dart:async';
import 'dart:io';

import 'package:gestion_jeu_de_societe/BoardGameModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "jds.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE BoardGame ("
          "id INTEGER PRIMARY KEY,"
          "nom TEXT,"
          "genre TEXT,"
          "coop INTEGER,"
          "nbrJoueurMin INTEGER,"
          "nbrJoueurMax INTEGER,"
          "age INTEGER,"
          "type TEXT,"
          "editeur TEXT,"
          "auteur TEXT,"
          "description TEXT,"
          "photo TEXT"
          ")");
    });
  }

  newBoardGame(BoardGame newBoardGame) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM BoardGame");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into BoardGame (id,nom,genre,coop,nbrJoueurMin,nbrJoueurMax,age,type,editeur,auteur,description,photo)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          id,
          newBoardGame.nom,
          newBoardGame.genre,
          newBoardGame.coop,
          newBoardGame.nbrJoueurMin,
          newBoardGame.nbrJoueurMax,
          newBoardGame.age,
          newBoardGame.type,
          newBoardGame.editeur,
          newBoardGame.auteur,
          newBoardGame.descritpion,
          newBoardGame.photo
        ]);
    return raw;
  }

  updateBoardGame(BoardGame newBoardGame) async {
    final db = await database;
    var res = await db.update("BoardGame", newBoardGame.toMap(),
        where: "id = ?", whereArgs: [newBoardGame.id]);
    return res;
  }

  getBoardGame(int id) async {
    final db = await database;
    var res = await db.query("BoardGame", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? BoardGame.fromMap(res.first) : null;
  }

  Future<List<BoardGame>> getAllBoardGames() async {
    final db = await database;
    var res = await db.query("BoardGame");
    List<BoardGame> list =
        res.isNotEmpty ? res.map((c) => BoardGame.fromMap(c)).toList() : [];
    return list;
  }

  deleteBoardGame(int id) async {
    final db = await database;
    return db.delete("BoardGame", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }
}
