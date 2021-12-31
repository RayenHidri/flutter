// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:mni_projet/Components/db.dart';
import 'package:mni_projet/models/family.dart';

class AddFamily extends StatefulWidget {
  const AddFamily({Key? key}) : super(key: key);

  @override
  AddFamilyState createState() => AddFamilyState();
}

final box = GetStorage();
final nameInput = TextEditingController();
final EditNameInput = TextEditingController();
List<Map<String, Object?>>? list;
getFams() {
  MyDatabase.db.queryAllFamily().then((value) => list = value);
  print('-------');
  print(list);
}

//final list= MyDatabase.db.queryAllFamily().then(value);
class AddFamilyState extends State<AddFamily> {


  @override
  Widget build(BuildContext context) {
    getFams();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Manage Families"),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: Container(
                width: 200,
                height: 150,
              ),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: nameInput,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter the name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: ElevatedButton(
              onPressed: () {
                MyDatabase.db.newFamily(Family(nameInput.text));
              },
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: FutureBuilder(
              future: MyDatabase.db.queryAllFamily(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, Object?>>?> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  reverse: false,
                  itemBuilder: (context, index) {
                    var item;
                    snapshot.data![index].forEach((key, value) {item = value;});
                    return GestureDetector (child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue)
                    ),
                    child:Text(item.toString(),style: TextStyle(color: Colors.black, fontSize: 25))
                    ),
                    onLongPress: () => {
                      Navigator.of(context).restorablePush(_dialogBuilder,arguments: {'"name"':'"'+item.toString()+'"'})
                    },
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

    static Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
      Family f = Family.fromMap(jsonDecode(arguments.toString())); 
       EditNameInput.text = f.name;
      
  return DialogRoute<void>(
    context: context,
    builder: (BuildContext context) =>  AlertDialog(title: Text("Modify / Delete ?"),content: 
    Column(children: [
     Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              
              controller: EditNameInput,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter the name'),
            ),
          ), 
      Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: ElevatedButton(
              onPressed: () {
                print("modify pressed");
                MyDatabase.db.modifyFamily(f, EditNameInput.text);
              },
              child: Text(
                "Modify",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: ElevatedButton(
              onPressed: () async {
                print("delete pressed");
               MyDatabase.db.deleteFamily(Family(EditNameInput.text));
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
    ],))
  );
}
}
