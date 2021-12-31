import 'package:flutter/material.dart';
import 'package:mni_projet/Components/AddFamily.dart';
import 'package:mni_projet/Components/AddLoans.dart';
import 'package:mni_projet/Components/AddMember.dart';
import 'package:mni_projet/Components/AddComponent.dart';
import 'package:mni_projet/Components/LoginPage.dart';
import 'Components/AddComponent.dart';
import 'Components/homepage.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        "/home":(context){return HomePage();},
        "/ajoutcomposant":(context){return AddComponent();},
        "/ajoutemprunt":(context){return AddLoans();},
        "/ajoutfamille":(context){return AddFamily();},
        "/ajoutmember":(context){return AddMember();},
        "/deco":(context){return LoginPage();},
      },
      theme: ThemeData(
          primarySwatch: Colors.pink
      ),
      initialRoute :"/home",
    );
  }
}


