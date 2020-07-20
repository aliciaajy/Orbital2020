import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/widgets/custom_button.dart';
import 'package:login/pages/type_of_list.dart';

class TravelListHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TravelList();
}

class TravelList extends State<TravelListHomePage> {
  PageController _pageController = PageController();
  double currentPage = 0;
  String input = "";
  // TextEditingController mycontroller = TextEditingController();
  static List<Packing> packinglist = List<Packing>();
  static List<Itinerary> itinerarylist = new List<Itinerary>();

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
                      currentPage == 0 ? "Add New Item" : "Add New Destination",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  content: TextField(
                    decoration: InputDecoration(
                        hintText:
                            currentPage == 0 ? 'Enter item' : "Enter location"),
                    onChanged: (String value) {
                      input = currentPage == 0
                          ? (packinglist.length + 1).toString() + ". " + value
                          : (itinerarylist.length + 1).toString() +
                              ". " +
                              value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          currentPage == 0
                              ? packinglist.add(Packing(input))
                              : itinerarylist.add(Itinerary(input));
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
            "Travel List",
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
            packingbodycontent(context),
            itinerarybodycontent(context)
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
          buttonText: "Packing List",
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
          buttonText: "Itinerary List",
          color: currentPage > 0.5 ? Colors.purple : Colors.white,
          textColor: currentPage > 0.5 ? Colors.white : Colors.purple,
          borderColor: currentPage > 0.5 ? Colors.transparent : Colors.purple,
        ))
      ],
    );
  }

  Widget packingbodycontent(BuildContext context) {
    return ListView.builder(
        itemCount: packinglist.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              key: UniqueKey(), //Key(shoplist[index]),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: Icon(Icons.card_travel, color: Colors.purpleAccent),
                  title: Text(packinglist[index].item),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.purple,
                    ),
                    onPressed: () {
                      setState(() {
                        packinglist.removeAt(index);
                      });
                    },
                  ),
                ),
              ));
        });
  }

  Widget itinerarybodycontent(BuildContext context) {
    return ListView.builder(
        itemCount: itinerarylist.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              key: UniqueKey(), //Key(shoplist[index]),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: Icon(Icons.airplanemode_active,
                      color: Colors.purpleAccent),
                  title: Text(itinerarylist[index].place),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.purple,
                    ),
                    onPressed: () {
                      setState(() {
                        itinerarylist.removeAt(index);
                      });
                    },
                  ),
                ),
              ));
        });
  }
}

class Itinerary {
  String place;
  Itinerary(this.place);
}

class Packing {
  String item;
  Packing(this.item);
}
