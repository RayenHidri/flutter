import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mni_projet/Components/AddFamily.dart';
import 'package:mni_projet/Components/AddMember.dart';
import 'package:mni_projet/Components/LoginPage.dart';


import 'Components/AddComponent.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home Page"),
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
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/gstock.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddFamily()));

                 },
                child: Text('Add Family'),
              ),
            ),
           Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) =>AddComponent()));

                 },
                child: Text('Add Component'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddMember()));

                 },
                child: Text('Add Member'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () { 

                 },
                child: Text('Edit Component Quantity'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () { 

                 },
                child: Text('Add Loans'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () { 

                 },
                child: Text('Edit Loans'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () { 

                 },
                child: Text('Show Loaned Components'),
              ),
            ),
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () { 
                  box.write("session", false);
                  box.listen(() { 
                    if (box.read("session") == false) {
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                    }
                  });
                 },
                child: Text('Log Out'),
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