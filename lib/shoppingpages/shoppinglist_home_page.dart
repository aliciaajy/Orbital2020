import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/pages/type_of_list.dart';
import 'package:login/widgets/custom_button.dart';
import 'package:login/backgroundpage/background.dart';

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

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: new AssetImage(BackgroundPage().getBackgroundAssetName()),
          )), //Theme.of(context).accentColor,
        ),
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
                      input = (shoplist.length + 1).toString() + ". " + value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          shoplist.add(ShopList(input));
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
            "Shopping List",
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
          children: <Widget>[bodycontent(context)],
        ))
      ],
    );
  }

  Widget bodycontent(BuildContext context) {
    return ListView.builder(
        itemCount: shoplist.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              key: UniqueKey(), //Key(shoplist[index]),
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
                    shoplist[index].item,
                    style: TextStyle(
                        decoration: (shoplist[index].done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.purple,
                    ),
                    onPressed: () {
                      setState(() {
                        shoplist.removeAt(index);
                      });
                    },
                  ),
                ),
              ));
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
