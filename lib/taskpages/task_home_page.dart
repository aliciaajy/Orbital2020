import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/pages/type_of_list.dart';
import 'package:login/widgets/custom_date_time_picker.dart';
import 'package:login/widgets/custom_button.dart';
import 'package:login/widgets/custom_icon_decoration.dart';

class MyTaskHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: "Montserrat"),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = PageController();
  double currentPage = 0;
  String input = "";
  TextEditingController mycontroller = TextEditingController();
  static List<TaskList> tasklist = List<TaskList>();
  static List<EventList> eventlist = new List<EventList>();
  DateTime _selectedDate = DateTime.now();
  //String _selecteddate = 'Pick a date';
  String _selectedTime = 'Pick a time';

  Future _pickTime() async {
    TimeOfDay timepicked = await showTimePicker(
        context: context, initialTime: new TimeOfDay.now());
    if (timepicked != null) {
      setState(() {
        _selectedTime = timepicked.toString();
      });
    }
  }

  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));

    if (datepick != null)
      setState(() {
        _selectedDate = datepick;
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
                      currentPage == 0 ? "Add New Task" : "Add New Event",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  content: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 24,
                        ),
                        TextField(
                            controller: mycontroller,
                            decoration: InputDecoration(
                                hintText: currentPage == 0
                                    ? 'Enter task'
                                    : "Enter event"),
                            onChanged: (String value) {
                              input = currentPage == 0
                                  ? (tasklist.length + 1).toString() +
                                      ". " +
                                      value
                                  : value;
                            }),
                        currentPage == 0
                            ? CustomDateTimePicker(
                                icon: Icons.date_range,
                                onPressed: _pickDate,
                                value: new DateFormat("dd-MM-yyyy")
                                    .format(_selectedDate))
                            : CustomDateTimePicker(
                                icon: Icons.access_time,
                                onPressed: _pickTime,
                                value: _selectedTime,
                              ),
                      ]),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          currentPage == 0
                              ? tasklist.add(TaskList(input))
                              : eventlist.add(EventList(input, _selectedTime));
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
            "To-Do List",
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
            taskbodycontent(context),
            eventbodycontent(context)
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
          buttonText: "Tasks ",
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
          buttonText: "Events",
          color: currentPage > 0.5 ? Colors.purple : Colors.white,
          textColor: currentPage > 0.5 ? Colors.white : Colors.purple,
          borderColor: currentPage > 0.5 ? Colors.transparent : Colors.purple,
        ))
      ],
    );
  }

  Widget taskbodycontent(BuildContext context) {
    return ListView.builder(
        itemCount: tasklist.length,
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
                      value: tasklist[index].done,
                      onChanged: (checked) {
                        setState(() {
                          tasklist[index].done = checked;
                        });
                      }),
                  title: Text(
                    tasklist[index].task,
                    style: TextStyle(
                        decoration: (tasklist[index].done
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
                        tasklist.removeAt(index);
                      });
                    },
                  ),
                ),
              ));
        });
  }

  Expanded _displayContent(EventList event) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x20000000),
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(event.event),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _displayTime(String time) {
    return Container(
        width: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(time),
        ));
  }

  Container _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool done) {
    return Container(
        decoration: CustomIconDecoration(
            firstData: index == 0 ?? true,
            lastData: index == listLength - 1 ?? true,
            iconSize: iconSize,
            lineWidth: 1),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3),
                    color: Color(0x20000000),
                    blurRadius: 5)
              ]),
          child: Icon(
              eventlist[index].done
                  ? Icons.fiber_manual_record
                  : Icons.radio_button_unchecked,
              size: iconSize,
              color: Colors.purple),
        ));
  }

  Widget eventbodycontent(BuildContext context) {
    double iconSize = 20;
    return ListView.builder(
      itemCount: eventlist.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24),
          child: Row(
            children: <Widget>[
              _lineStyle(context, iconSize, index, eventlist.length,
                  eventlist[index].done),
              _displayTime(eventlist[index].time),
              _displayContent(eventlist[index])
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    mycontroller.dispose();
  }
}

class TaskList {
  String task;
  bool done;
  TaskList(this.task) : done = false;
}

class EventList {
  String event;
  bool done;
  String time;
  EventList(this.event, this.time) : done = false;
}
