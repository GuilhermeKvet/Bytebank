import 'package:new_bytebank/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Funcao que cria uma tabela no banco de dados. Retorna a tabela.
Future<Database> createDatabase() async {
  //FEITO COM ASYNC/AWAIT
  final String path = join(await getDatabasesPath(), "new_bytebank.db");
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.tableSql);
    },
    version: 1,
  );
  //FEITO COM THEN
  // return getDatabasesPath().then((dbPath) {
  //   final String path = join(dbPath, 'new_bytebank.db');
  //   return openDatabase(
  //     path,
  //     onCreate: (db, version) {
  //       db.execute('CREATE TABLE contacts('
  //           'id INTEGER PRIMARY KEY, '
  //           'name TEXT, '
  //           'accountNumber INTEGER)');
  //     },
  //     version: 1,
  //     //Comando onDowngrade serve para limpar o banco de dados.
  //     // onDowngrade: onDatabaseDowngradeDelete,
  //   );
  // });
}
