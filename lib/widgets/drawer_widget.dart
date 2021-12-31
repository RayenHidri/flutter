import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors:[
                        Colors.black12,
                        Colors.pinkAccent,
                      ]
                  )
              ),
              child: CircleAvatar(
                backgroundImage:AssetImage("assets/images/gstock.png"),
                radius:50,
              )),
          ListTile(
            title:Text("Gestion des familles", style:TextStyle(fontSize: 15),),
            leading:Icon(Icons.family_restroom,color:Colors.pinkAccent),
            trailing: Icon(Icons.arrow_right,color:Colors.grey),
            onTap: (){
              Navigator.pushNamed(context,"/ajoutfamille");
            },
          ),
          Divider(height:5,color:Colors.black),
          ListTile(
            title:Text("Gestion des composants", style:TextStyle(fontSize: 15),),
            leading:Icon(Icons.settings_input_composite,color:Colors.pinkAccent),
            trailing: Icon(Icons.arrow_right,color:Colors.grey),
            onTap:(){
              Navigator.of(context).pop();
              Navigator.pushNamed(context,"/ajoutcomposant");
            },
          ),
          Divider(height:5,color:Colors.black,),
          ListTile(
            title:Text("Gestion des membres", style:TextStyle(fontSize: 15),),
            leading:Icon(Icons.accessibility_new_outlined,color:Colors.pinkAccent),
            trailing: Icon(Icons.arrow_right,color:Colors.grey),
            onTap:(){
              Navigator.of(context).pop();
              Navigator.pushNamed(context,"/ajoutmember");
            },
          ),
          Divider(height:5,color:Colors.black,),
          ListTile(
            title:Text("Gestion des emprunts", style:TextStyle(fontSize: 15),),
            leading:Icon(Icons.volunteer_activism,color:Colors.pinkAccent),
            trailing: Icon(Icons.arrow_right,color:Colors.grey),
            onTap:(){
              Navigator.of(context).pop();
              Navigator.pushNamed(context,"/ajoutemprunt");
            },
          ),
          Divider(height:5,color:Colors.black,),
          ListTile(
            title:Text("Deconnexion", style:TextStyle(fontSize: 15),),
            leading:Icon(Icons.close,color:Colors.pinkAccent),
            onTap:(){
              Navigator.of(context).pop();
              Navigator.pushNamed(context,"/deco");
            },
          ),
        ],
      ),

    );
  }
}