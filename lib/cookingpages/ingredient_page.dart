import 'package:flutter/material.dart';
import 'package:login/cookingpages/add_ingredient_page.dart';

class IngredientListHomePage extends StatefulWidget {
  @override
  State createState() => IngredientPageState();
}

class IngredientPageState extends State<IngredientListHomePage> {
  // static List<IngredList> ingredlist = new List<IngredList>();
  // static List getingredlist(){
  //   return ingredlist;
  // }
  List ingredlist = IngredientList.getingredlist();
  @override
  void initState() {
    super.initState();
  }
 
  Widget build(BuildContext context) {
    return Scaffold(
      body : ListView.builder(
        itemCount: ingredlist.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),//Key(shoplist[index]),
            child: Card(
               elevation: 10,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(16)),
                 child: ListTile(
                   leading: Icon(Icons.check, color: Colors.purpleAccent),
                   title: Text(ingredlist[index].ingred,
                   ),
                   trailing: IconButton(
                     icon: Icon(
                       Icons.delete,
                       color: Colors.purple,
                       ),
                       onPressed: () {
                         setState(() {
                            ingredlist.removeAt(index);
                             });
                              }
                         )
                         )
                       )
                 );
              })
    );
  }
}
// class IngredList {
//   String ingred;
//   IngredList(this.ingred);

// }
