// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mni_projet/auth/db.dart';
import 'package:mni_projet/models/family.dart';

class AddFamily extends StatefulWidget {
  const AddFamily({Key? key}) : super(key: key);

  @override
  AddFamilyState createState() => AddFamilyState();
}

final box = GetStorage();
final nameInput = TextEditingController();
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
        title: Text("Add Family"),
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
                    return Text(snapshot.data![index].values.toString());
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
