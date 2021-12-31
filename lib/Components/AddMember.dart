import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/member.dart';
import 'db.dart';

class AddMember extends StatefulWidget {
  AddMember({Key? key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}
final box = GetStorage();
final firstNameInput = TextEditingController();
final lastNameInput = TextEditingController();
final num1Input = TextEditingController();
final num2Input = TextEditingController();

final editFirstName = TextEditingController();
final editLastName = TextEditingController();
final editNum1 = TextEditingController();
final editNum2 = TextEditingController();

class _AddMemberState extends State<AddMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Manage Members"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                controller: firstNameInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                    hintText: 'Enter the first name'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: lastNameInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                    hintText: 'Enter the last name'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller:num1Input,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number 1',
                    hintText: 'Enter the first number'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: num2Input,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number 2 ',
                    hintText: 'Enter the second number'),
              ),
            ),
            Padding(
             padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child:  ElevatedButton(
                onPressed: () {
                      MyDatabase.db.newMember(Member.withoutId(firstNameInput.text,lastNameInput.text
                      ,int.parse(num1Input.text),int.parse(num2Input.text)));
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
              future: MyDatabase.db.queryAllMemeber(),
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
                    final item = {};
        
                   snapshot.data![index].forEach((key, value) { 
                    item[key]=value;
                   });
                   Member c = Member.fromMap(Map.from(item));
                  box.write(c.id.toString(), c.toMap());
                    return GestureDetector (child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue)
                    ),
                    child: Row(children: [
                      
                      Text(c.first_name.toString() ,style: TextStyle(color: Colors.black, fontSize: 20)),
                      Text(" | Phone: " ,style: TextStyle(color: Colors.black, fontSize:20 )),
                      Text(c.num1.toString() ,style: TextStyle(color: Colors.black, fontSize: 20))
                    ],)
                    ),
                    onLongPress: () => {
                      Navigator.of(context).restorablePush(_dialogBuilder,arguments: {'"id"':'"'+c.id.toString()+'"'})
                    },
                    );
                  },
                );
              },
            ),
          ),
          ]
        ),
      ),
    );
  }
  
    static Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
      //Family f = Family.fromMap(jsonDecode(arguments.toString())); 
     //  EditfirstNameInput.text = f.name;
     var params = jsonDecode(arguments.toString());
     Member c = Member.noParams();
     c.id = int.parse(params["id"]);
     c = Member.fromMap(box.read(c.id.toString()));
     editFirstName.text = c.first_name.toString();
     editNum1.text = c.num1.toString();
     editNum2.text = c.num2.toString();
     editLastName.text = c.last_name.toString();

  return DialogRoute<void>(
    context: context,
    builder: (BuildContext context) =>  AlertDialog(title: Text("Modify / Delete ?"),content: 
    SingleChildScrollView(
          child: Column(children: [
       Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: editFirstName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter the name'),
              ),
            ), 
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: editLastName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Family Name',
                    hintText: 'Enter the family name'),
              ),
            ),
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: editNum1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantity',
                    hintText: 'Enter quantity'),
              ),
            ),
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: editNum2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                    hintText: 'Enter the date'),
              ),
            ),
        Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: ElevatedButton(
                onPressed: () {
                  print("modify pressed");
                 MyDatabase.db.modifyMember(Member(c.id,editFirstName.text
                  , editLastName.text, int.parse(editNum1.text),int.parse(editNum2.text)));
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
                 MyDatabase.db.deleteMember(c.id);
                },
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
      ],),
    ))
  );
}
}