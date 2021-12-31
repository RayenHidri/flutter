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
    String path = join(getDatabasesPath().toString(), "projet.db");
    return await openDatabase(path, version: 2, onOpen: (db) async{
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
      "name TEXTPRIMARY KEY)"
      ); 


      await db.execute("CREATE TABLE IF NOT EXISTS member("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "first_name TEXT NOT NULL,"
      "last_name TEXT NOT NULL,"
      "num1 INTEGER NOT NULL,"
      "num2 INTEGER)");

      await db.execute("CREATE TABLE IF NOT EXISTS component("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "name TEXT NOT NULL,"
      "family TEXT NOT NULL,"
      "quantity INTEGER NOT NULL,"
      "date Date)"); 

      await db.execute("CREATE TABLE IF NOT EXISTS loans("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "nameMember TEXT NOT NULL,"
      "nameComponent TEXT NOT NULL,"
      "dateEmp Date,"
      "dateReturn Date)"); 

      await db.execute("update component set quantity= ? where name=?"
      ); 
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
    var res = await db?.insert("Member", newMember.toMap());
    return res;
  }
  newComponent(Component newComponent) async {
    final db = await database;
    var res = await db?.insert("Component", newComponent.toMap());
    return res;
  }
  newLoans(Loans newLoans) async {
    final db = await database;
    var res = await db?.insert("Loans", newLoans.toMap());
    return res;
  }
  Future<List<Map<String, Object?>>?> queryAllFamily() async {
        final db = await database;
    var list = await db?.rawQuery("SELECT * FROM Family");
      return list;
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
  Future<Member> getMember(String first_name) async {
    final db = await database;
    var res = await  db?.query("Member",where: "first_name = ?", whereArgs: [first_name]);
    print("--el get -"+res.toString());
    if (res!.isNotEmpty) {
      return Member.fromMap(res.first);
    }
    else
    {
      return Member.withoutId("","",-1,-1);
    }
    
  }
   Future<Component> getComponent(String name) async {
    final db = await database;
    var res = await  db?.query("Component",where: "name = ?", whereArgs: [name]);
    print("--el get -"+res.toString());
    if (res!.isNotEmpty) {
      return Component.fromMap(res.first);
    }
    else
    {
      return Component.withoutId("","",0,DateTime.parse("DD/MM/YYYY"));
    }
    }
    Future<Loans> getLoans(String first_name) async {
    final db = await database;
    var res = await  db?.query("Loans",where: "first_name = ?", whereArgs: [first_name]);
    print("--el get -"+res.toString());
    if (res!.isNotEmpty) {
      return Loans.fromMap(res.first);
    }
    else
    {
      return Loans.withoutId("","",DateTime.parse("DD/MM/YYYY"),DateTime.parse("DD/MM/YYYY"));
    }
    
  }

}
