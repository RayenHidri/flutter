import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mni_projet/models/loans.dart';

import 'db.dart';

class AddLoans extends StatefulWidget {
  const AddLoans({ Key? key }) : super(key: key);

  @override
  _AddLoansState createState() => _AddLoansState();
}
final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
var box = GetStorage();
var idMInput = TextEditingController();
var idCInput = TextEditingController();
var datEmpInput = TextEditingController();
var idMInputEdit = TextEditingController();
var idCInputEdit = TextEditingController();
var datEmpInputEdit = TextEditingController();
var datRetInput = TextEditingController();
var dateRetourInput = TextEditingController();
var loanInput = TextEditingController();
bool returned = false;
int returnedInput = 0;
String statusDropdownValue = "Select State";
String memberDropdownValue = 'Select a member';
String memberEditDropdownValue = 'Select a member';
String componentDropdownValue = 'Select a component';
String componentEditDropdownValue = 'Select a component';
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
              child: FutureBuilder(
      future: MyDatabase.db.queryAllMemeber(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, Object?>>?> snapshot) { 
          if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<DropdownMenuItem<String>>? results = [
                  DropdownMenuItem(child: Text("Select a member"),value: "Select a member",),
                ];
                var item = {};
                snapshot.data!.forEach((element) {
                  element.forEach((key, value) { 
                    item[key] = value;
                  });
                  DropdownMenuItem<String> row = DropdownMenuItem(child: Text(item['first_name']+" "+item["last_name"]),value: item['id'].toString(),);
                  results.add(row);
                 });

                 print(results.toString());


          return Row(children: <Widget>[
             Text('Member : ', 
          style: TextStyle
              (fontSize: 19, 
              color: Colors.grey)),
            Text("   "),
 
          DropdownButton<String>(
            value: memberDropdownValue,
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
                memberDropdownValue = data.toString();
              });
              idMInput.text = memberDropdownValue.toString();
            },
            items: results
          ),
          ]);      
     },
          
    )
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder(
      future: MyDatabase.db.queryAllComponent(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, Object?>>?> snapshot) { 
          if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<DropdownMenuItem<String>>? results = [
                  DropdownMenuItem(child: Text("Select a component"),value: "Select a component",),
                ];
                var item = {};
                snapshot.data!.forEach((element) {
                  element.forEach((key, value) { 
                    item[key] = value;
                  });
                  DropdownMenuItem<String> row = DropdownMenuItem(child: Text(item['name']),value: item['id'].toString(),);
                  results.add(row);
                 });

                 print(results.toString());


          return Row(children: <Widget>[
             Text('Component : ', 
          style: TextStyle
              (fontSize: 15, 
              color: Colors.grey)),
            Text("   "),
 
          DropdownButton<String>(
            value: componentDropdownValue,
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
                componentDropdownValue = data.toString();
              });
              idCInput.text = componentDropdownValue.toString();
              
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
                controller:datEmpInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date emprunt',
                    hintText: 'Enter the date of emprunt'),
              ),
            ),
            
            Padding(
             padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child:  ElevatedButton(
                onPressed: () {
                      MyDatabase.db.newLoans(Loans.withoutId(int.parse(idMInput.text), int.parse(idCInput.text),DateFormat('yyyy-MM-dd').parse(datEmpInput.text),0));
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
              future: MyDatabase.db.queryAllLoans(),
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
                    var item = {};
                   snapshot.data![index].forEach((key, value) { 
                    item[key]=value;
                   });
                   print(item.toString()); 
                   Loans c = Loans.noParams();
                   if (item['returned'] != 0)
                   c = Loans.fromMap(Map.from(item));
                   else 
                   c = Loans.fromMapNoReturn(Map.from(item));
                   
                   
                 
                    return GestureDetector (child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue)
                    ),
                    child: Row(children: [
                      Text(c.idMember.toString() ,style: TextStyle(color: Colors.black, fontSize: 20)),
                      Text(" - " ,style: TextStyle(color: Colors.black, fontSize: 20)),
                      Text(c.DateEmp.toString().substring(0,10) ,style: TextStyle(color: Colors.black, fontSize: 20)),
                      Text(" - " ,style: TextStyle(color: Colors.black, fontSize: 20)),
                     
                    
                    ],)
                    ),
                    onLongPress: () async=> {
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
  
Future<void> showInformationDialog(BuildContext context, Loans l) async {
  
idMInputEdit.text = l.idMember.toString();
idCInputEdit.text = l.idComponent.toString();
datEmpInputEdit.text = l.DateEmp.toString().substring(0,10);
memberEditDropdownValue = l.idMember.toString();
componentEditDropdownValue = l.idComponent.toString();
if (l.returned == 1) {
  returned = true;
  returnedInput = 1;
  dateRetourInput.text = l.DateReturn.toString().substring(0,10);
  statusDropdownValue = l.returnCond.toString();
}
else {
  returned = false;
  returnedInput = 0;
  dateRetourInput.text ="";
  statusDropdownValue = "Select State";
  }
    return await showDialog(
        context: context,
        builder: (context) {
          bool? isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey1,
                  child: SingleChildScrollView(
                                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       SingleChildScrollView(
          child: Column(children: [
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: FutureBuilder(
      future: MyDatabase.db.queryAllMemeber(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, Object?>>?> snapshot) { 
          if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                }
                List<DropdownMenuItem<String>>? results = [
                    DropdownMenuItem(child: Text("Select a member"),value: "Select a member",),
                ];
                var item = {};
                snapshot.data!.forEach((element) {
                    element.forEach((key, value) { 
                      item[key] = value;
                    });
                    DropdownMenuItem<String> row = DropdownMenuItem(child: Text(item['first_name']+" "+item["last_name"]),value: item['id'].toString(),);
                    results.add(row);
                 });

                 print(results.toString());


          return Row(children: <Widget>[
             
 
          DropdownButton<String>(
            value: memberEditDropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.blue, fontSize: 19),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String? data) {
              setState(() {
                memberEditDropdownValue = data.toString();
              });
              idMInputEdit.text = memberEditDropdownValue.toString();
            },
            items: results
          ),
          ]);      
     },
          
    )
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder(
      future: MyDatabase.db.queryAllComponent(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, Object?>>?> snapshot) { 
          if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                }
                List<DropdownMenuItem<String>>? results = [
                    DropdownMenuItem(child: Text("Select a component"),value: "Select a component",),
                ];
                var item = {};
                snapshot.data!.forEach((element) {
                    element.forEach((key, value) { 
                      item[key] = value;
                    });
                    DropdownMenuItem<String> row = DropdownMenuItem(child: Text(item['name']),value: item['id'].toString(),);
                    results.add(row);
                 });

                 print(results.toString());


          return Row(children: <Widget>[
             
 
          DropdownButton<String>(
            value: componentEditDropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.blue, fontSize: 19),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String? data) {
              setState(() {
                componentDropdownValue = data.toString();
              });
              idCInputEdit.text = componentEditDropdownValue.toString();
              
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
                controller:datEmpInputEdit,
                decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Date emprunt',
                      hintText: 'Enter the date of emprunt'),
              ),
            ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Text('Returned : '),
            Checkbox(value: returned, onChanged: (value) => {
            setState(() {
              returned = value!;
              if (returned) returnedInput = 1;
              else returnedInput = 0;
            })
          }),
          ],)),
          Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
      value: statusDropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.blue,fontSize: 19),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: returned ? (String? newValue) {
        setState(() {
          statusDropdownValue = newValue!;
        });
      } : null,
      items: <String>['Select State','Safe', 'Damaged', 'Hardly Damaged']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    )
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                enabled: returned,
                controller:dateRetourInput,
                decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Date emprunt',
                      hintText: 'Enter the date of emprunt'),
              ),
            ),
      Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: ElevatedButton(
              onPressed: () {
                print("modify pressed");
               MyDatabase.db.modifyLoan(Loans(int.parse(idMInputEdit.text),int.parse(idCInputEdit.text),DateFormat('yyyy-MM-dd').parse(datEmpInputEdit.text),DateFormat('yyyy-MM-dd').parse(dateRetourInput.text),returnedInput,statusDropdownValue));
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
               MyDatabase.db.deleteLoan(Loans.withoutId(int.parse(idMInputEdit.text),int.parse(idCInputEdit.text),DateFormat('yyyy-MM-dd').parse(datEmpInputEdit.text),0));
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
      
      ],),
                        
                       )],
              ),
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