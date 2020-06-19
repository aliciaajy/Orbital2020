import 'package:flutter/material.dart';
//import 'package:login/pages/task_page.dart';
import 'package:login/pages/task_home_page.dart';

class Option extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Type of List",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(title:Text("Choose Your List")),
        body: ListOption()
        ),
    );
  }
}

class ListOption extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return _myListOption(context);
  }
}

Widget _myListOption(BuildContext context) {
  return ListView(
    children:  <Widget> [
      Card(
        child: ListTile(
          leading: Icon(Icons.list, size:60),
          title: Text("To Do List"),
          subtitle: Text("List your tasks and plan your day with us"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyTaskHomePage(),)
            );
          },
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.local_grocery_store, size:60),
          title: Text("Grocery List"),
          subtitle: Text("List your items and shop together with us"),
          trailing: Icon(Icons.keyboard_arrow_right),
         
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.fastfood, size:60),
          title: Text("Cooking List"),
          subtitle: Text("List your recipes and cook with us"),
          trailing: Icon(Icons.keyboard_arrow_right),
          
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.airplanemode_active,size:60),
          title: Text("Travel List"),
          subtitle: Text("List your itineraries and travel with us"),
          trailing: Icon(Icons.keyboard_arrow_right),
          
        ),
      ),
    ],
  );
}



