import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/widgets/custom_button.dart';
import 'package:login/pages/type_of_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  createPackinglist() {
    DocumentReference documentReference =
        Firestore.instance.collection("TravelList - packing").document(input);

    Map<String, String> items = {"packingListTitle": input};

    documentReference.setData(items).whenComplete(() {
      print("$input created");
    });
  }

  createItinerary() {
    DocumentReference documentReference =
        Firestore.instance.collection("TravelList - itinerary").document(input);

    Map<String, String> itinerary = {"itineraryTitle": input};

    documentReference.setData(itinerary).whenComplete(() {
      print("$input created");
    });
  }

  deletePackinglist(item) {
    DocumentReference documentReference =
        Firestore.instance.collection("TravelList - packing").document(item);

    documentReference.delete().whenComplete(() {
      print("$item deleted");
    });
  }

  deleteItinerary(item) {
    DocumentReference documentReference =
        Firestore.instance.collection("TravelList - itinerary").document(item);

    documentReference.delete().whenComplete(() {
      print("$item deleted");
    });
  }

  String _selected = '';

  Image _setBackground() {
    return new Image(
      image: new AssetImage(_selected),
      fit: BoxFit.cover,
      color: Colors.black54,
      colorBlendMode: BlendMode.darken,
    );
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
                      currentPage == 0 ? "Add New Item" : "Add New Destination",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  content: TextField(
                    decoration: InputDecoration(
                        hintText:
                            currentPage == 0 ? 'Enter item' : "Enter location"),
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          currentPage == 0
                              ? createPackinglist()
                              : createItinerary();
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
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    setState(() {
                      _selected = 'assets/kakao.jpg';
                      _setBackground();
                    });
                  },
                ),
                IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () {
                      setState(() {
                        _selected = 'assets/motivational.jpg';
                        _setBackground();
                      });
                    }),
                IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () {
                      setState(() {
                        _selected = 'assets/bts.jpg';
                        _setBackground();
                      });
                    }),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    setState(() {
                      _selected = 'assets/shop.jpg';
                      _setBackground();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    setState(() {
                      _selected = 'assets/menu.jpg';
                      _setBackground();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    setState(() {
                      _selected = 'assets/ad.jpg';
                      _setBackground();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    setState(() {
                      _selected = 'assets/plane.jpg';
                      _setBackground();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    setState(() {
                      _selected = 'assets/nature.jpg';
                      _setBackground();
                    });
                  },
                ),
              ])),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Scaffold(
        //crossAxisAlignment: CrossAxisAlignment.start,
        body: new Stack(fit: StackFit.expand, children: <Widget>[
      _setBackground(),
      Column(
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
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.purpleAccent),
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
      )
    ]));
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
    return StreamBuilder<QuerySnapshot>(
        stream:
            Firestore.instance.collection("TravelList - packing").snapshots(),
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
                          deletePackinglist(
                              documentSnapshot["packingListTitle"]);
                        },
                        key: Key(documentSnapshot[
                            "packingListTitle"]), //Key(shoplist[index]),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            leading: Icon(Icons.card_travel,
                                color: Colors.purpleAccent),
                            title: Text(documentSnapshot["packingListTitle"]),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.purple,
                              ),
                              onPressed: () {
                                setState(() {
                                  deletePackinglist(
                                      documentSnapshot["packingListTitle"]);
                                });

                                // setState(() {
                                //   packinglist.removeAt(index);
                                // });
                              },
                            ),
                          ),
                        ));
                  });
          }
        });
  }

  Widget itinerarybodycontent(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            Firestore.instance.collection("TravelList - itinerary").snapshots(),
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
                          deleteItinerary(documentSnapshot["itineraryTitle"]);
                        },
                        key: Key(documentSnapshot[
                            "itineraryTitle"]), //Key(shoplist[index]),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            leading: Icon(Icons.airplanemode_active,
                                color: Colors.purpleAccent),
                            title: Text(documentSnapshot["itineraryTitle"]),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.purple,
                              ),
                              onPressed: () {
                                deleteItinerary(
                                    documentSnapshot["itineraryTitle"]);
                                // setState(() {
                                //   itinerarylist.removeAt(index);
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

class Itinerary {
  String place;
  Itinerary(this.place);
}

class Packing {
  String item;
  Packing(this.item);
}
