import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:mni_projet/models/component.dart';
import 'db.dart';

class AddComponent extends StatefulWidget {
  AddComponent({Key? key}) : super(key: key);

  @override
  _AddComponentState createState() => _AddComponentState();
}

 String dropdownValue = 'Select a family';
 String editDropdownValue = 'Select a family';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final box = GetStorage();
final nameInput = TextEditingController();
final famInput = TextEditingController();
final quantInput = TextEditingController();
final datInput = TextEditingController();

final editName = TextEditingController();
final editFamName = TextEditingController();
final editQuant = TextEditingController();
final editDate = TextEditingController();

class _AddComponentState extends State<AddComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("ajout composant"),
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
              child: FutureBuilder(
      future: MyDatabase.db.queryAllFamily(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, Object?>>?> snapshot) { 
          if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<DropdownMenuItem<String>>? results = [
                  DropdownMenuItem(child: Text("Select a family"),value: "Select a family",),
                ];
                final item = {};
                snapshot.data!.forEach((element) {
                  element.forEach((key, value) { 
                    item[key] = value;
                  });
                  DropdownMenuItem<String> row = DropdownMenuItem(child: Text(item['name']),value: item['name'],);
                  results.add(row);
                 });

                 print(results.toString());


          return Row(children: <Widget>[
             Text('Family : ', 
          style: TextStyle
              (fontSize: 22, 
              color: Colors.grey)),
            Text("   "),
 
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.blue, fontSize: 22),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String? data) {
              setState(() {
                dropdownValue = data.toString();
              });
              box.write('famSelected' , data.toString());
            },
            items: results
          ),
          ]);      
     },
          
    )
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
                    hintText: 'YYYY-MM-DD'),
              ),
            ),
            Padding(
             padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child:  ElevatedButton(
                onPressed: () {
                 // print("ki nzelt 3la add :"+box.read("famSelected"));
                      MyDatabase.db.newComponent(Component.withoutId(nameInput.text,box.read('famSelected'), 
                      int.parse(quantInput.text), DateFormat('yyyy-MM-dd').parse(datInput.text)));
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
              future: MyDatabase.db.queryAllComponent(),
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
                   Component c = Component.fromMap(Map.from(item));
                   
                  box.write(c.id.toString(), c.toMap());
                  print("---------------------- map ki njy bch nhotha fl box : "+box.read(c.id.toString()).toString());
                    return GestureDetector (child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue)
                    ),
                    child: Row(children: [
                      Text(c.id.toString() ,style: TextStyle(color: Colors.black, fontSize: 25)),
                      Text(" - " ,style: TextStyle(color: Colors.black, fontSize: 25)),
                      Text(c.name.toString() ,style: TextStyle(color: Colors.black, fontSize: 25))
                    ],)
                    ),
                    onLongPress:  () async => {
                     // Navigator.of(context).restorablePush(_dialogBuilder,arguments: {'"id"':'"'+c.id.toString()+'"'})
                      await showInformationDialog(context,c)
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
  
Future<void> showInformationDialog(BuildContext context, Component c) async {
  editName.text = c.name.toString();
  editQuant.text = c.quantity.toString();
  editDropdownValue = c.family.toString();
  editDate.text = c.date.toString().substring(0,10);
  editFamName.text = c.family.toString();
    return await showDialog(
        context: context,
        builder: (context) {
          bool? isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     SingleChildScrollView(
          child: Column(children: [
       Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: editName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter the name'),
              ),
            ), 
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: FutureBuilder(
      future: MyDatabase.db.queryAllFamily(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, Object?>>?> snapshot) { 
          if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<DropdownMenuItem<String>>? results = [
                  DropdownMenuItem(child: Text("Select a family"),value: "Select a family",),
                ];
                final item = {};
                snapshot.data!.forEach((element) {
                  element.forEach((key, value) { 
                    item[key] = value;
                  });
                  DropdownMenuItem<String> row = DropdownMenuItem(child: Text(item['name']),value: item['name'],);
                  results.add(row);
                 });


          return Row(children: <Widget>[
             Text('Family : ', 
          style: TextStyle
              (fontSize: 16, 
              color: Colors.grey)),
            Text("   "),
 
          DropdownButton<String>(
            value: editDropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.blue, fontSize: 16),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String? data) {
              setState(() {
                editDropdownValue = data.toString();
              });
              editFamName.text = data.toString();
              box.write('famSelected' , data.toString());
              print("----- el onchange mt3 el dialog : value : "+editFamName.text.toString());
            },
            items: results
          ),
          ]);      
     },
          
    ),
            ),
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: editQuant,
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
                controller: editDate,
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
                  MyDatabase.db.modifyComponent(Component(c.id,editName.text
                  , editFamName.text, int.parse(editQuant.text),DateFormat('yyyy-MM-dd').parse(editDate.text)));
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
                 MyDatabase.db.deleteComponent(c.id);
                },
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
      ],),
                      
                     )],
              )),
              title: Text('Modify / Delete ?'),
              actions: <Widget>[
                InkWell(
                  child: Text('Close   '),
                  onTap: () {
                    
                      Navigator.of(context).pop();
                    
                  },
                ),
              ],
            );
          });
        });
  }
}