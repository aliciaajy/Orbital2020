import 'package:flutter/material.dart';
//import 'package:login/pages/task_page.dart';
import 'package:login/taskpages/task_home_page.dart';
import 'package:login/shoppingpages/shoppinglist_home_page.dart';
import 'package:login/cookingpages/cookinglist_home_page.dart';
import 'package:login/travelpages/travelList_homepage.dart';

class Option extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Type of List",
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize:Size.fromHeight(60),
          child: AppBar(title:Text("Choose Your List",
          style: TextStyle(fontSize: 25.0)),
          backgroundColor: Colors.purple,
          actions: <Widget> [
          Icon(Icons.settings, size:20.0)
        ],
          elevation: 10.0,
          leading:Icon(Icons.menu, size:20),
          )

      ),
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
      Card(child: ListTile(
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
          title: Text("Shopping List"),
          subtitle: Text("List your items and shop together with us"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShoppingListHomePage(),)
            );
          },
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.fastfood, size:60),
          title: Text("Cooking List"),
          subtitle: Text("List your recipes and cook with us"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CookingListHomePage(),)
            );
          }
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.airplanemode_active,size:60),
          title: Text("Travel List"),
          subtitle: Text("List your itineraries and travel with us"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TravelListHomePage(),)
            );
          }
        ),
      ),
    ],
  );
}



