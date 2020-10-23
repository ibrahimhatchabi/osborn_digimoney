
class User {
  static final String columnId = "id";
  static final String columnNom = "nom";
  static final String columnPrenom = "prenom";
  static final String columnTelephone = "telephone";
  static final String columnShop = "shop";
  static final String columnAdresse = "adresse";
  static final String columnFontion = "fonction";
  static final String columnIdentifiant = "identifiant";
  static final String columnPassword = "password";

  User({
    this.id,
    this.nom,
    this.prenom,
    this.telephone,
    this.shop,
    this.adresse,
    this.fonction,
    this.identifiant,
    this.password,
  });

  final String id;
  final String nom;
  final String prenom;
  final String telephone;
  final String shop;
  final String adresse;
  final String fonction;
  final String identifiant;
  final String password;

  Map toMap() {
    Map<String, dynamic> map = {
      columnId: id,
      columnNom: nom,
      columnPrenom: prenom,
      columnShop: shop,
      columnAdresse: adresse,
      columnFontion: fonction,
      columnTelephone: telephone,
      columnIdentifiant: identifiant,
      columnPassword: password
    };
    return map;
  }

  static User fromMap(Map map) {
    return User(
        id: map[columnId],
        nom: map[columnNom],
        prenom: map[columnPrenom],
        shop: map[columnShop],
        adresse: map[columnAdresse],
        telephone: map[columnTelephone],
        identifiant: map[columnIdentifiant],
        password: map[columnPassword]
    );
  }
}

