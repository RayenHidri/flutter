import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'db.dart';
class DropDown extends StatefulWidget {
  @override
  DropDownWidget createState() => DropDownWidget();
}
 
class DropDownWidget extends State {
 
  String dropdownValue = 'Select a family';
 List <String> spinnerItems = [
    'One', 
    'Two', ];
 
final box = GetStorage("componentView");

 
  @override
  Widget build(BuildContext context) {
   
    box.write('famSelected', "");
    return FutureBuilder(
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
          
    );
  }
}