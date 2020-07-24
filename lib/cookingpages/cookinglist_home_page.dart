import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/widgets/custom_button.dart';
import 'package:login/pages/type_of_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CookingListHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CookingList();
}

class CookingList extends State<CookingListHomePage> {
  PageController _pageController = PageController();
  double currentPage = 0;
  String input = "";

  static List<IngredList> ingredlist = List<IngredList>();
  static List<Recipe> recipelist = new List<Recipe>();

  createItem() {
    DocumentReference documentReference = Firestore.instance.collection("CookingList - ingred").document(input);

    Map<String, String> items = {"itemTitle": input};

    documentReference.setData(items).whenComplete(() {
      print("$input created");
    });
  }

  createRecipe() {
    DocumentReference documentReference = Firestore.instance.collection("CookingList - recipe").document(input);

    Map<String, String> recipes = {"recipeTitle": input};

    documentReference.setData(recipes).whenComplete(() {
      print("$input created");
    });
  }

  deleteItem(item) {
    DocumentReference documentReference = Firestore.instance.collection("CookingList - ingred").document(item);

    documentReference.delete().whenComplete(() {
      print("$item deleted");
    });
  }

  deleteRecipe(item) {
    DocumentReference documentReference = Firestore.instance.collection("CookingList - recipe").document(item);

    documentReference.delete().whenComplete(() {
      print("$item deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: 35, color: Colors.purple //Theme.of(context).accentColor,
              ),
          _mainContent(context),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                      currentPage == 0 ? "Add New Ingredient" : "Add New Steps",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  content: TextField(
                    decoration: InputDecoration(
                        hintText: currentPage == 0
                            ? 'Enter ingredient'
                            : "Enter steps"),
                    onChanged: (String value) {
                      input = currentPage == 0
                          ? (ingredlist.length + 1).toString() + ". " + value
                          : (recipelist.length + 1).toString() + ". " + value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          currentPage == 0
                          ? createItem()
                          : createRecipe();
                              // ? ingredlist.add(IngredList(input))
                              // : recipelist.add(Recipe(input));
                          Navigator.pop(context);
                        });
                      },
                      child: Text("Add"),
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        elevation: 50,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ),
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
              ])),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 60),
        IconButton(
          icon: Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Option()),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            "Cooking List",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _button(context),
        ),
        Expanded(
            child: PageView(
          controller: _pageController,
          children: <Widget>[
            ingredbodycontent(context),
            recipebodycontent(context)
          ],
        ))
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: CustomButton(
          onPressed: () {
            _pageController.previousPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut);
          },
          buttonText: "Ingredient",
          color: currentPage < 0.5
              ? Colors.purple
              : Colors.white, //Theme.of(context).accentColor : Colors.white,
          textColor: currentPage < 0.5 ? Colors.white : Colors.purple,
          borderColor: currentPage < 0.5 ? Colors.transparent : Colors.purple,
        )),
        SizedBox(
          width: 32,
        ),
        Expanded(
            child: CustomButton(
          onPressed: () {
            _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut);
          },
          buttonText: "Preparations",
          color: currentPage > 0.5 ? Colors.purple : Colors.white,
          textColor: currentPage > 0.5 ? Colors.white : Colors.purple,
          borderColor: currentPage > 0.5 ? Colors.transparent : Colors.purple,
        ))
      ],
    );
  }

  Widget ingredbodycontent(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("CookingList - ingred").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
        if (snapshots.hasError)
          return Text('Error: ${snapshots.error}');
          switch (snapshots.connectionState) {
            case ConnectionState.waiting: return Text('Loading...');
            default: 

        return ListView.builder(
          shrinkWrap: true,
        itemCount: snapshots.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot documentSnapshot = snapshots.data.documents[index];
          return Dismissible(
            onDismissed: (direction) {
              deleteItem(documentSnapshot["itemTitle"]);
            },
              key: Key(documentSnapshot["itemTitle"]), //Key(shoplist[index]),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: Icon(Icons.check, color: Colors.purpleAccent),
                  title: Text(documentSnapshot["itemTitle"]),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.purple,
                    ),
                    onPressed: () {
                      deleteItem(documentSnapshot["itemTitle"]);
                      // setState(() {
                      //   ingredlist.removeAt(index);
                      // });
                    },
                  ),
                ),
              ));
        });
          }
      });
  }

  Widget recipebodycontent(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("CookingList - recipe").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
        if (snapshots.hasError)
          return Text('Error: ${snapshots.error}');
          switch (snapshots.connectionState) {
            case ConnectionState.waiting: return Text('Loading...');
            default: 

        return ListView.builder(
          shrinkWrap: true,
        itemCount: snapshots.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot documentSnapshot = snapshots.data.documents[index];
          return Dismissible(
            onDismissed: (direction) {
              deleteRecipe(documentSnapshot["recipeTitle"]);
            },
              key: Key(documentSnapshot["recipeTitle"]), //Key(shoplist[index]),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: Icon(Icons.local_dining, color: Colors.purpleAccent),
                  title: Text(documentSnapshot["recipeTitle"]),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.purple,
                    ),
                    onPressed: () {
                      deleteRecipe(documentSnapshot["recipeTitle"]);
                      // setState(() {
                      //   recipelist.removeAt(index);
                      // });
                    },
                  ),
                ),
              ));
        });
          }
      });
  }
}

class IngredList {
  String ingred;
  IngredList(this.ingred);
}

class Recipe {
  String recipe;
  Recipe(this.recipe);
}
