import 'package:sqflite/sqflite.dart';

import '../database/app_database.dart';
import '../models/Contact.dart';

class ContactDao {
  static const String id = 'id';
  static const String name = 'name';
  static const String account = 'accountNumber';
  static const String tableName = 'contacts';
  //Usa o statc para evitar instancias
  static const String tableSql = 'CREATE TABLE $tableName('
      '$id INTEGER PRIMARY KEY, '
      '$name TEXT, '
      '$account INTEGER)';

  //Funcao que escreve na tabela do Banco de dados. Retorna a tabela prenchida.
  Future<int> save(Contact contact) async {
    //FEITO COM ASYNC/AWAIT
    final Database db = await createDatabase();
    final Map<String, dynamic> contactMap = {};
    contactMap[name] = contact.name;
    contactMap[account] = contact.accountNumber;
    return db.insert(tableName, contactMap);
    //FEITO COM THEN
    // return createDatabase().then((db) {
    //   final Map<String, dynamic> contactMap = Map();
    //   contactMap[name] = contact.name;
    //   contactMap[accountNumber] = contact.accountNumber;
    //   return db.insert(tableName, contactMap);
    // });
  }

//Funcao que devolve no formato de array, os itens do banco de dados.
  Future<List<Contact>> findAll() async {
    //FEITO COM ASYNC/AWAIT
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> results = await db.query(tableName);
    final List<Contact> contacts = [];
    for (Map<String, dynamic> row in results) {
      final Contact contact = Contact(
        row[id],
        row[name],
        row[account],
      );
      contacts.add(contact);
    }
    return contacts;
    //FETO COM THEN
    // return createDatabase().then((db) {
    //   return db.query(tableName).then((maps) {
    //     final List<Contact> contacts = [];
    //     for (Map<String, dynamic> map in maps) {
    //       final Contact contact = Contact(
    //         map[id],
    //         map[name],
    //         map[accountNumber],
    //       );
    //       contacts.add(contact);
    //     }
    //     return contacts;
    //   });
    // });
  }
}
