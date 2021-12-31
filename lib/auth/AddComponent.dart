import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mni_projet/models/component.dart';

import 'db.dart';

class AddComponent extends StatefulWidget {
  AddComponent({Key? key}) : super(key: key);

  @override
  _AddComponentState createState() => _AddComponentState();
}
final box = GetStorage();
final nameInput = TextEditingController();
final famInput = TextEditingController();
final quantInput = TextEditingController();
final datInput = TextEditingController();

class _AddComponentState extends State<AddComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Component"),
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
                controller: nameInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Component Name',
                    hintText: 'Enter the name'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: famInput,
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
                controller:quantInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Component Quantity',
                    hintText: 'Enter the Quantity'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: datInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date ',
                    hintText: 'Enter the date'),
              ),
            ),
            Padding(
             padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child:  ElevatedButton(
                onPressed: () {
                      MyDatabase.db.newComponent(Component.withoutId(nameInput.text, famInput.text, int.parse(quantInput.text), DateTime.parse(datInput.text)));
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