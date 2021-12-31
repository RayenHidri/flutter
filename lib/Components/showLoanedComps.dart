import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mni_projet/models/loans.dart';
import 'db.dart';

class ShowLoanedComps extends StatefulWidget {
  @override
  _ShowLoanedCompsState createState() => _ShowLoanedCompsState();
}

class _ShowLoanedCompsState extends State<ShowLoanedComps> {

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Show Loaned Components"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: FutureBuilder(
              future: MyDatabase.db.queryAllNotReturnedLoans(),
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
                   print("-----------------------------------------");
                   print(item.toString()); 
                   Loans c = Loans.noParams();
                   
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
                    
                    },
                    );
                  },
                );
              },
            ),
          ),
            
            SizedBox(
              height: 130,
            ),
            
          ],
        ),
      ),
    );
  }
}