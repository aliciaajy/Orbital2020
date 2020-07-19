import 'package:flutter/material.dart';
//import 'package:login/pages/task_page.dart';
import 'package:login/taskpages/task_home_page.dart';
import 'package:login/shoppingpages/shoppinglist_home_page.dart';
import 'package:login/cookingpages/cookinglist_home_page.dart';
import 'package:login/travelpages/travelList_homepage.dart';
import 'package:login/pages/settings.dart';

class Option extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Type of List",
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
              title: Text("Choose Your List",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.purple,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Settings())),
                )
              ]),
        ),
        body: ListOption(),
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
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
          height: 140,
          child: Card(
            elevation: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(Icons.list, size: 80, color: Colors.purpleAccent),
              title: Text(
                "To Do List",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text("List your tasks and plan your day with us",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic)),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyTaskHomePage(),
                    ));
              },
            ),
          )),
      Container(
        height: 140,
        child: Card(
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: Icon(Icons.local_grocery_store,
                size: 80, color: Colors.purpleAccent),
            title: Text(
              "Shopping List",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text("List your items and shop together with us",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontStyle: FontStyle.italic)),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingListHomePage(),
                  ));
            },
          ),
        ),
      ),
      Container(
        height: 140,
        child: Card(
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
              leading: Icon(
                Icons.fastfood,
                size: 80,
                color: Colors.purpleAccent,
              ),
              title: Text(
                "Cooking List",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text("List your recipes and cook with us",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic)),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CookingListHomePage(),
                    ));
              }),
        ),
      ),
      Container(
        height: 140,
        child: Card(
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
              leading: Icon(Icons.airplanemode_active,
                  size: 80, color: Colors.purpleAccent),
              title: Text(
                "Travel List",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text("List your itineraries and travel with us",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic)),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TravelListHomePage(),
                    ));
              }),
        ),
      ),
    ],
  );
}
