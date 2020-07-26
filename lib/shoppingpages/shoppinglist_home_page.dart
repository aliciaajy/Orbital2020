import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:login/pages/type_of_list.dart';
import 'package:login/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingListHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShoppingList();
}

class ShoppingList extends State<ShoppingListHomePage> {
  PageController _pageController = PageController();
  double currentPage = 0;

  static List<ShopList> shoplist = List<ShopList>();
  String input = "";

  @override
  void initState() {
    super.initState();
  }

  createShoppingItem() {
    DocumentReference documentReference =
        Firestore.instance.collection("ShoppingList").document(input);

    Map<String, String> items = {"itemTitle": input};

    documentReference.setData(items).whenComplete(() {
      print("$input created");
    });
  }

  deleteShoppingItem(item) {
    DocumentReference documentReference =
        Firestore.instance.collection("ShoppingList").document(item);

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
      body: Stack(children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Option()),
            );
          },
        ),
        Container(
          height: 35,
          color: Colors.purple,
        ), //Theme.of(context).accentColor,
        _mainContent(context)
      ]),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Add new item"),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          if (currentPage == 0) {
                            createShoppingItem();
                            shoplist.add(ShopList(input ?? ''));
                          }
                        });
                        Navigator.pop(context);
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
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ),
                IconButton(
                    icon: Icon(Icons.people),
                    onPressed: () {
                      setState(() {
                        _selected = 'assets/motivational.jpg';
                        _setBackground();
                      });
                    }),
                IconButton(
                    icon: Icon(Icons.crop_original),
                    onPressed: () {
                      setState(() {
                        _selected = 'assets/nature.jpg';
                        _setBackground();
                      });
                    }),
              ])),
    );
  }

  String _selected = "";

  Image _setBackground() {
    return new Image(
      image: new AssetImage(_selected),
      fit: BoxFit.cover,
      color: Colors.black54,
      colorBlendMode: BlendMode.darken,
    );
  }

  Widget _mainContent(BuildContext context) {
    return Scaffold(
        //crossAxisAlignment: CrossAxisAlignment.start,
        body: new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        _setBackground(),
        // IconButton(
        //   icon: Icon(Icons.arrow_back, size: 30),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => Option()),
        //     );
        //   },
        // ),
        Column(children: <Widget>[
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Shopping List",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: _button(context),
          ),
          Expanded(
              child: PageView(
            controller: _pageController,
            children: <Widget>[bodycontent(context)],
          ))
        ])
      ],
    ));
  }

  Widget bodycontent(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("ShoppingList").snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasError) return Text('Error: ${snapshots.error}');
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshots.data.documents[index];
                    return Dismissible(
                        onDismissed: (direction) {
                          deleteShoppingItem(documentSnapshot["itemTitle"]);
                        },
                        key: Key(documentSnapshot[
                            "itemTitle"]), //Key(shoplist[index]),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            leading: Checkbox(
                                activeColor: Colors.purple,
                                checkColor: Colors.white,
                                value: shoplist[index].done,
                                onChanged: (checked) {
                                  setState(() {
                                    shoplist[index].done = checked;
                                  });
                                }),
                            title: Text(
                              documentSnapshot["itemTitle"],
                              // shoplist[index].item,
                              // style: TextStyle(
                              //     decoration: (shoplist[index].done
                              //         ? TextDecoration.lineThrough
                              //         : TextDecoration.none)),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.purple,
                              ),
                              onPressed: () {
                                deleteShoppingItem(
                                    documentSnapshot["itemTitle"]);
                                // setState(() {
                                //   //shoplist.removeAt(index);
                                //   deleteShoppingItem(documentSnapshot["itemTitle"]);
                                // });
                              },
                            ),
                          ),
                        ));
                  });
          }
        });
  }

  Widget _button(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: CustomButton(
        onPressed: () {
          _pageController.previousPage(
              duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
        },
        buttonText: "Items",
        color: currentPage > 0.5 ? Colors.white : Colors.purple,
        textColor: currentPage > 0.5 ? Colors.purple : Colors.white,
        borderColor: currentPage > 0.5 ? Colors.purple : Colors.transparent,
      ))
    ]);
  }
}

class ShopList {
  String item;
  bool done;
  ShopList(this.item) : done = false;
}
