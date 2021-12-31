// ignore: file_names
// ignore: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mni_projet/models/admin.dart';

import '../homepage.dart';
import 'db.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
final box = GetStorage();
final emailInput = TextEditingController();
final passwordInput = TextEditingController();

loginVerif() {
  print("Clicked");
  bool msg = false;
   MyDatabase.db.getAdmin(emailInput.text).then((value) => {
  print("-verif: "+value.username),
   if (value.username != "" && value.password == passwordInput.text) {
     print("logging in success"),
     box.write("session", true)
     
   }
   else {
     box.write("loginError", true)
     
   }
 });

 }


class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    box.write("loginError", false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
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
                    child: Image.asset('assets/images/logo.jpg')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordInput,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your Password'),
              ),
            ),
            Padding(
             padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: ElevatedButton(
                onPressed: () {
                 //MyDatabase.db.newAdmin(Admin("adminjs@gmail.com","admin12345"));
                loginVerif();

                box.listen(() {
                  if (box.read("session")){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                  else if (box.read("loginError") == true) {
                    Navigator.of(context).restorablePush(_dialogBuilder);
                  } 
                
                });
                },
                 
                  
                
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
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
  static Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
  return DialogRoute<void>(
    context: context,
    builder: (BuildContext context) => const AlertDialog(title: Text("Error"),content: Text("Check your credentials")),
  );
}
}
