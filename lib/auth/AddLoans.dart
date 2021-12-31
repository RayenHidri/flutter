import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mni_projet/models/loans.dart';

import 'db.dart';

class AddLoans extends StatefulWidget {
  const AddLoans({ Key? key }) : super(key: key);

  @override
  _AddLoansState createState() => _AddLoansState();
}
final box = GetStorage();
final nameMInput = TextEditingController();
final nameCInput = TextEditingController();
final datEmpInput = TextEditingController();
final datRetInput = TextEditingController();
class _AddLoansState extends State<AddLoans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Loans"),
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
                controller: nameMInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name Member',
                    hintText: 'Enter your Firstname'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: nameCInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Component Name',
                    hintText: 'Enter the name of component'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller:datEmpInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date emprunt',
                    hintText: 'Enter the date of emprunt'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: datRetInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'date Return',
                    hintText: 'Enter the date of return'),
              ),
            ),
            Padding(
             padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child:  ElevatedButton(
                onPressed: () {
                      MyDatabase.db.newLoans(Loans.withoutId(nameMInput.text, nameCInput.text,  DateTime.parse(datEmpInput.text), DateTime.parse( datRetInput.text)));
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