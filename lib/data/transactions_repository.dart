import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osborn_digimoney/data/database.dart';
import 'package:osborn_digimoney/model/transaction.dart';
import 'package:osborn_digimoney/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  static const String TRANSACTION_TABLE_NAME = "transactions";
  static const String USER_TABLE_NAME = "users";
  static const String KEY_LAST_FETCH = "last_fetch";
  static const int MILLISECONDS_IN_AN_HOUR = 360000;
  static const int REFRESH_THRESHOLD = 3 * MILLISECONDS_IN_AN_HOUR;

  static Future<List<User>> initUsers(String shopName) async {
    List<User> users = [];

    users = await _getUsersFromFirestore(shopName);

    await _insertUsersInDatabase(users);

    return users;
  }

  static Future<List<OPTransaction>> _getTransactionsFromFirestore() async {
    CollectionReference transactionRef = Firestore.instance.collection('transaction');
    QuerySnapshot transactionsQuery = await transactionRef
      // Add time condition
      // .where("time", isGreaterThan: DateTime.now().millisecondsSinceEpoch)
      .getDocuments();
    return transactionsQuery.documents.map((document){
      return OPTransaction(
        agent: document['agent'],
        date: document['date'],
        montant: document['montant'],
        numero: document['numero'],
        type: document['type'],
        status: document['status'],
        creditOuCash: document['creditOuCash'],
        observations: document['observations'],
      );
    }).toList();
  }

  static Future<List<User>> _getUsersFromFirestore(String shopName) async {
    CollectionReference transactionRef = Firestore.instance.collection('users');
    print("************* ShopName = "+shopName);
    QuerySnapshot transactionsQuery = await transactionRef
      .where("shop", isEqualTo: shopName)
      .getDocuments();
    return transactionsQuery.documents.map((document){
      return User(
        id: document['id'],
        nom: document['nom'],
        prenom: document['prenom'],
        telephone: document['telephone'],
        shop: document['shop'],
        adresse: document['adresse'],
        fonction: document['fonction'],
        identifiant: document['identifiant'],
        password: document['password'],
      );
    }).toList();
  }

  static Future<bool> shouldBackup() async {
    Database dbClient = await OperationsDatabase().db;
    List<Map<String, dynamic>> transactionsToBackup = await dbClient.query(
        TRANSACTION_TABLE_NAME,
        where: 'status = ?',
        whereArgs: ['pending']
    );

    return transactionsToBackup.length > 0;
  }

  static Future<List<OPTransaction>> getTransactionsFromDatabase() async{
    Database dbClient = await OperationsDatabase().db;
    List<Map<String, dynamic>> transactionsFromDatabase = await dbClient.query(TRANSACTION_TABLE_NAME);
    return transactionsFromDatabase.map((transaction) => OPTransaction.fromMap(transaction)).toList();
  }

  static Future<List<OPTransaction>> getLatestTransactionsFromDatabase() async{
    Database dbClient = await OperationsDatabase().db;
    List<Map<String, dynamic>> transactionsToBackup = await dbClient.query(
      TRANSACTION_TABLE_NAME,
      where: 'status = ?',
      whereArgs: ['pending']
    );
    return transactionsToBackup.map((transaction) => OPTransaction.fromMap(transaction)).toList();
  }

  static void _setLastFetchTimeToNow() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(KEY_LAST_FETCH, DateTime.now().millisecondsSinceEpoch);
  }

  static Future _insertTransactionsInDatabase(List<OPTransaction> trasactions) async {
    Database dbClient = await OperationsDatabase().db;

    // dbClient.delete(TRANSACTION_TABLE_NAME);

    trasactions.forEach((trasaction) async {
      int transactionId = await dbClient.insert(TRANSACTION_TABLE_NAME, trasaction.toMap());
      print("trasanctionId is:" + transactionId.toString());
    });
  }

  static Future backUpTrasactions(List<OPTransaction> trasactions) async {
    Database dbClient = await OperationsDatabase().db;

    List<OPTransaction> localTransactions = await getLatestTransactionsFromDatabase();

    CollectionReference transactionRef = Firestore.instance.collection('transactions');

    localTransactions.forEach((transaction) async {

      //await transactionRef.add(trasaction.toMap());
      await transactionRef.document().setData(
        {
          'agent': transaction.agent,
          'date': transaction.date,
          'montant': transaction.montant,
          'numero': transaction.numero,
          'type': transaction.type,
          'creditOuCash': transaction.creditOuCash,
          'observations': transaction.observations
        }
      );
      dbClient.update(TRANSACTION_TABLE_NAME, {'status':'syncd'}, where: 'status = ?', whereArgs: ['pending']);
    });

  }

  static Future<int> insertOneTransactionInDatabase(OPTransaction trasaction) async {
    Database dbClient = await OperationsDatabase().db;

    int transactionId = await dbClient.insert(TRANSACTION_TABLE_NAME, trasaction.toMap());
    print("trasanctionId is:" + transactionId.toString());

    return transactionId;
  }

  static Future _insertUsersInDatabase(List<User> users) async {
    Database dbClient = await OperationsDatabase().db;

    users.forEach((user) async {
      int userId = await dbClient.insert(USER_TABLE_NAME, user.toMap());
      print("userId is:" + userId.toString());
    });
  }
}

