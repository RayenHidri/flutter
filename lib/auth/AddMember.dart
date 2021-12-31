import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mni_projet/models/member.dart';

import 'db.dart';

class AddMember extends StatefulWidget {
  const AddMember({ Key? key }) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}
final box = GetStorage();
final fnameInput = TextEditingController();
final lnameInput = TextEditingController();
final num1Input = TextEditingController();
final num2Input = TextEditingController();

class _AddMemberState extends State<AddMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Member"),
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
                controller: fnameInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'FirstName',
                    hintText: 'Enter the Firstname'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: lnameInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'LastName',
                    hintText: 'Enter the Lastname'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller:num1Input,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone number 1',
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
                    labelText: 'Phone number 2',
                    hintText: 'Enter the second number'),
              ),
            ),
            Padding(
             padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child:  ElevatedButton(
                onPressed: () {
                      MyDatabase.db.newMember(Member.withoutId(fnameInput.text, lnameInput.text, int.parse(num1Input.text), int.parse(num2Input.text)));
                },
                child: Text(
                  "Add",
                 style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                ),
              ),
          ]
        ),
      ),
    );
  }
}