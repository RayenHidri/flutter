import 'package:flutter/material.dart';
import 'package:mni_projet/widgets/drawer_widget.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:MyDrawer(),
      appBar: AppBar(title: Text("Espace Admin"),),
      body: Center(child: Text("Espace Admin",
        style: Theme.of(context).textTheme.headline3,
      ),
      ),
    );
  }
}