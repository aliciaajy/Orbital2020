import 'package:flutter/material.dart';
import 'package:login/cookingpages/add_recipe_page.dart';


class RecipeListHomePage extends StatefulWidget {
  @override
  State createState() => RecipePageState();
}

class RecipePageState extends State<RecipeListHomePage> {
  List recipelist = RecipeList.getrecipelist();
  @override
  void initState() {
    super.initState();
  }
 
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: recipelist.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),//Key(shoplist[index]),
            child: Card(
               elevation: 10,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(16)),
                 child: ListTile(
                   leading: Icon(Icons.local_dining, color: Colors.purple),
                   title: Text(recipelist[index].recipe,
                   ),
                   trailing: IconButton(
                     icon: Icon(
                       Icons.delete,
                       color: Colors.purple,
                       ),
                       onPressed: () {
                         setState(() {
                            recipelist.removeAt(index);
                             });
                              }
                         )
                         )
                       )
                 );
              });
  }
}
