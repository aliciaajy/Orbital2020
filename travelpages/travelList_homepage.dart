import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/widgets/custom_button.dart';
import 'package:login/travelpages/add_itinerary_page.dart';
import 'package:login/travelpages/add_packing_page.dart';
import 'package:login/travelpages/itinerary_page.dart';
import 'package:login/travelpages/packing_page.dart';

class TravelListHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TravelList();
} 

class TravelList extends State<TravelListHomePage> {
  PageController _pageController = PageController();
  double currentPage = 0;
  String input = "";

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
            height: 35,
            color: Colors.purple   //Theme.of(context).accentColor,
          ),
        _mainContent(context),
        ], 
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        showDialog(
          barrierDismissible: false,
          context: context, 
          builder: (BuildContext context) {
            return Dialog(
              child: currentPage == 0 ? AddPackingList() : AddItineraryList(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))));
          });
      },
      child: Icon(Icons.add,),
      backgroundColor: Colors.purple,
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
              onPressed: () {},
          )
          ],
          ),
      ),
      );
  }

   Widget _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
          "Travel List", 
          style: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _button(context),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            children: <Widget>[PackingListHomePage(), ItineraryListHomePage()],
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
                color: 
                currentPage < 0.5 ? Colors.purple :Colors.white,//Theme.of(context).accentColor : Colors.white,
                textColor: 
                currentPage < 0.5 ? Colors.white : Colors.purple,
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
                color: 
                currentPage > 0.5 ? Colors.purple : Colors.white,
                textColor: 
                currentPage > 0.5 ? Colors.white : Colors.purple,
                borderColor: currentPage > 0.5 ? Colors.transparent : Colors.purple,
                ))
            ],
          );
        }
      }
      