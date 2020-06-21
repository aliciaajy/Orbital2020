import 'package:flutter/material.dart';
import 'package:login/travelpages/add_itinerary_page.dart';


class ItineraryListHomePage extends StatefulWidget {
  @override
  State createState() => ItineraryPageState();
}

class ItineraryPageState extends State<ItineraryListHomePage> {
  List itinerarylist = ItineraryList.getitinerarylist();
  @override
  void initState() {
    super.initState();
  }
 
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: itinerarylist.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),//Key(shoplist[index]),
            child: Card(
               elevation: 10,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(16)),
                 child: ListTile(
                   leading: Icon(Icons.airplanemode_active, color: Colors.purple),
                   title: Text(itinerarylist[index].place,
                   ),
                   trailing: IconButton(
                     icon: Icon(
                       Icons.delete,
                       color: Colors.purple,
                       ),
                       onPressed: () {
                         setState(() {
                            itinerarylist.removeAt(index);
                             });
                              }
                         )
                         )
                       )
                 );
              });
  }
}