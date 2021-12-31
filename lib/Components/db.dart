import 'dart:developer';

import 'package:mni_projet/models/admin.dart';
import 'package:mni_projet/models/component.dart';
import 'package:mni_projet/models/family.dart';
import 'package:mni_projet/models/loans.dart';
import 'package:mni_projet/models/member.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  MyDatabase._();
  static final MyDatabase db = MyDatabase._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    // if _database is null we instantiate it
    _database = await initDB();
        return _database;
      }
    
    initDB() async {
    String path = join(getDatabasesPath().toString(), "projet_flutter_v1_1.db");
    return await openDatabase(path, version: 2, onOpen: (db) async{
      await db.execute("CREATE TABLE IF NOT EXISTS component("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "name TEXT NOT NULL UNIQUE,"
      "family TEXT NOT NULL,"
      "quantity INTEGER NOT NULL,"
      "date Date)"); 
      await db.execute("CREATE TABLE IF NOT EXISTS admin ("
          "username EMAIL PRIMARY KEY,"
          "password TEXT"
          ")");


      await db.execute("CREATE TABLE IF NOT EXISTS family("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "name TEXT NOT NULL)"
      ); 


      await db.execute("CREATE TABLE IF NOT EXISTS member("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "first_name TEXT NOT NULL,"
      "last_name TEXT NOT NULL,"
      "num1 INTEGER NOT NULL,"
      "num2 INTEGER)");
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE IF NOT EXISTS admin ("
          "username EMAIL PRIMARY KEY,"
          "password TEXT"
          ")");

      await db.execute('INSERT INTO admin values ("adminjs@gmail.com", "admin12345")');


      await db.execute("CREATE TABLE IF NOT EXISTS family("
      "name TEXT PRIMARY KEY)"
      ); 


      await db.execute("CREATE TABLE IF NOT EXISTS member("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "first_name TEXT NOT NULL,"
      "last_name TEXT NOT NULL,"
      "num1 INTEGER NOT NULL UNIQUE,"
      "num2 INTEGER UNIQUE)");

      await db.execute("CREATE TABLE IF NOT EXISTS component("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "name TEXT NOT NULL UNIQUE,"
      "family TEXT NOT NULL,"
      "quantity INTEGER NOT NULL,"
      "date Date,"
      "FOREIGN KEY(family) REFERENCES Family(name))"); 

      await db.execute("CREATE TABLE IF NOT EXISTS loans("
      "idMember INTEGER,"
      "idComponent INTEGER ,"
      "dateEmp Date NOT NULL,"
      "dateReturn Date ,"
      "returned INTEGER,"
      "returnCond TEXT,"
      "FOREIGN KEY(idMember) REFERENCES Member(id),"
      "FOREIGN KEY(idComponent) REFERENCES Component(id),"
      "PRIMARY KEY(idMember,idComponent,dateEmp))"); 

      
    });
    
  }
  newAdmin(Admin newAdmin) async {
    final db = await database;
    var res = await db?.insert("Admin", newAdmin.toMap());
    return res;
  }
   newFamily(Family newFamily) async {
    final db = await database;
    var res = await db?.insert("Family", newFamily.toMap());
    return res;
  }
  newMember(Member newMember) async {
    final db = await database;
    var res = await db?.insert("Member", newMember.toMapNoId());
    return res;
  }
  newComponent(Component c) async {
    print("t3adet el date");
    
    final db = await database;
    var res = await db?.insert("Component", c.toMapNoId());
    return res;
  }
  newLoans(Loans newLoans) async {
    final db = await database;
    var res = await db?.rawInsert("insert into loans (idMember,idComponent,DateEmp,returned) values (?,?,?,0)",[newLoans.idMember,newLoans.idComponent,newLoans.DateEmp.toString()]);
    return res;
  }
  Future<List<Map<String, Object?>>?> queryAllFamily() async {
        final db = await database;
    var list = await db?.rawQuery("SELECT * FROM Family");
      return list;
  }

  Future<List<Map<String, Object?>>?> queryAllComponent() async {
        final db = await database;
    var list = await db?.rawQuery("SELECT * FROM Component");
      return list;
  }

  Future<List<Map<String, Object?>>?> queryAllMemeber() async {
        final db = await database;
    var list = await db?.rawQuery("SELECT * FROM Member");
      return list;
  }

  Future<List<Map<String, Object?>>?> queryAllLoans() async {
        final db = await database;
    var list = await db?.rawQuery("SELECT * FROM Loans");
      return list;
  }

    Future<List<Map<String, Object?>>?> queryAllNotReturnedLoans() async {
        final db = await database;
    var list = await db?.rawQuery("SELECT * FROM Loans where returned = 0");
    print("el list fl base : "+list.toString());
      return list;
  }


  modifyFamily(Family f, String newName) async {
    final db = await database;
    db?.rawUpdate("update family set name = ? where name = ?",[newName,f.name]);
  }
  
   modifyComponent(Component c) async {
    final db = await database;
    //db?.rawUpdate("update component set name = ? family = ? quantity = ? date = ? where id = ?",[c.name,c.family,c.quantity,c.date.toString(),id]);
    db?.update("component", c.toMap(),where: "id = ?", whereArgs: [c.id]);
  }

  modifyMember(Member c) async {
    final db = await database;
    db?.update("member", c.toMap(),where: "id = ?", whereArgs: [c.id]);
  }

  modifyLoan(Loans l) async {
    final db = await database;
    db?.update("loans", l.toMapWithoutId(),where: "idMember = ? and idComponent = ? and dateEmp= ?", whereArgs: [l.idMember,l.idComponent,l.DateEmp.toString()]);
  }

  deleteComponent(int id) async{
      final db = await database;
      db?.rawDelete("DELETE FROM component where id = ?",[id]);
    }


  deleteFamily(Family fam) async{
    final db = await database;
    db?.rawDelete("DELETE FROM Family where name = ?",[fam.name]);
  }

  deleteMember(int id) async{
    final db = await database;
    db?.rawDelete("DELETE FROM member where id = ?",[id]);
  }

  deleteLoan(Loans l) async{
      final db = await database;
      db?.rawDelete("DELETE FROM loans where idMember = ? and idComponent = ? and dateEmp= ?",[l.idMember,l.idComponent,l.DateEmp.toString()]);
    }
  
  
  Future<Admin> getAdmin(String username) async {
    final db = await database;
    var res = await  db?.query("Admin",where: "username = ?", whereArgs: [username]);
    print("--el get -"+res.toString());
    if (res!.isNotEmpty) {
      return Admin.fromMap(res.first);
    }
    else
    {
      return Admin("","");
    }
    
  }

  Future<Family> getFamily(String name) async {
    final db = await database;
    var res = await  db?.query("Family",where: "name = ?", whereArgs: [name]);
    print("--el get -"+res.toString());
    if (res!.isNotEmpty) {
      return Family.fromMap(res.first);
    }
    else
    {
      return Family("");
    }
    
  }
  Future<Member> getMember(int id) async {
    final db = await database;
    var res = await  db?.query("Member",where: "id = ?", whereArgs: [id]);
    
    if (res!.isNotEmpty) {
      return Member.fromMap(res.first);
    }
    else
    {
      return Member.withoutId("","",-1,-1);
    }
    
  }
   Future<Component> getComponent(int id) async {
    final db = await database;
    var res = await  db?.query("Component",where: "id = ?", whereArgs: [id]);
    
    if (res!.isNotEmpty) {
      return Component.fromMap(res.first);
    }
    else
    {
      return Component.withoutId("","",0,DateTime.parse("DD/MM/YYYY"));
    }
    }
    
    
  

}
