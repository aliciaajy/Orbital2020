import 'package:flutter/material.dart';
import 'package:login/travelpages/add_packing_page.dart';


class PackingListHomePage extends StatefulWidget {
  @override
  State createState() => PackingPageState();
}

class PackingPageState extends State<PackingListHomePage> {
  List packinglist = PackingList.getpackinglist();
  @override
  void initState() {
    super.initState();
  }
 
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: packinglist.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),//Key(shoplist[index]),
            child: Card(
               elevation: 10,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(16)),
                 child: ListTile(
                   leading: Icon(Icons.card_travel, color: Colors.purple),
                   title: Text(packinglist[index].item,
                   ),
                   trailing: IconButton(
                     icon: Icon(
                       Icons.delete,
                       color: Colors.purple,
                       ),
                       onPressed: () {
                         setState(() {
                            packinglist.removeAt(index);
                             });
                              }
                         )
                         )
                       )
                 );
              });
  }
}