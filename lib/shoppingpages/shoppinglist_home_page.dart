
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShoppingListHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShoppingList();
} 

class ShoppingList extends State<ShoppingListHomePage> {
  static List<ShopList> shoplist = List<ShopList>();
  String input = "";
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('Shopping List', style:TextStyle(color:Colors.white )),
        backgroundColor: Colors.purple
      ),

      //backgroundColor: Colors.white,
      //backgroundColor: Color(0xFFEFEF4),
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
                      setState( () {
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
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {}
            ),

          ]
        )
      ),
      body: ListView.builder(
      itemCount: shoplist.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),//Key(shoplist[index]),
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

            title: Text(shoplist[index].item,
            style: TextStyle(
              decoration: (shoplist[index].done
              ? TextDecoration.lineThrough
              : TextDecoration.none)
              ),
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
        }
      )
    );
  }
}
class ShopList {
  String item;
  bool done;
  ShopList(this.item) : done = false;
}