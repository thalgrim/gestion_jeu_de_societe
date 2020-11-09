final String tableJeuDeSociete = 'BoardGame';
final String colonneId = 'id';
final String colonneNom = 'nom';
final String colonneGenre = 'genre';
final String colonneCoop = 'coop';
final String colonneNbrJoueurMin = 'nbrJoueurMin';
final String colonneNbrJoueurMax = 'nbrJoueurMax';
final String colonneAge = 'age';
final String colonneType = 'type';
final String colonneEditeur = 'editeur';
final String colonneAuteur = 'auteur';
final String colonneDescription = 'description';
final String colonnePhoto = 'photo';

class BoardGame {
  int id;
  String nom;
  String genre; // placement d'ouvrier, draft, deckbuilding...
  int coop;
  int nbrJoueurMin;
  int nbrJoueurMax;
  int age;
  String type; //expert, familial, ambiance ...
  String editeur;
  String auteur;
  String descritpion;
  String photo;

  BoardGame(
      {id,
      nom,
      genre,
      coop,
      nbrJoueurMin,
      nbrJoueurMax,
      age,
      type,
      editeur,
      auteur,
      description,
      photo});

  BoardGame.fromMap(Map<String, dynamic> map) {
    id = map[colonneId];
    nom = map[colonneNom];
    genre = map[colonneGenre];
    coop = map[colonneCoop];
    nbrJoueurMin = map[colonneNbrJoueurMin];
    nbrJoueurMax = map[colonneNbrJoueurMax];
    age = map[colonneAge];
    type = map[colonneType];
    editeur = map[colonneEditeur];
    auteur = map[colonneAuteur];
    descritpion = map[colonneDescription];
    photo = map[colonnePhoto];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colonneNom: nom,
      colonneGenre: genre,
      colonneCoop: coop,
      colonneNbrJoueurMin: nbrJoueurMin,
      colonneNbrJoueurMax: nbrJoueurMax,
      colonneAge: age,
      colonneType: type,
      colonneEditeur: editeur,
      colonneAuteur: auteur,
      colonneDescription: descritpion,
      colonnePhoto: photo,
    };
    if (id != null) {
      map[colonneId] = id;
    }
    return map;
  }
}
