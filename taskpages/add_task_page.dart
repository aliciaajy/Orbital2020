import 'package:flutter/material.dart';
import 'package:login/widgets/custom_date_time_picker.dart';
import 'package:login/widgets/custom_modal_action_button.dart';
import 'package:login/widgets/custom_textfield.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  String _selectedDate = 'Pick a date';
  String _selectedTime = 'Pick a date';

  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime.now().add(Duration(days: -365)), 
      lastDate: new DateTime.now().add(Duration(days: 365)));

      if (datepick != null) 
      setState(() {
        _selectedDate = datepick.toString();
      });
  } 

  Future _pickTime() async {
    TimeOfDay timepicked = await showTimePicker(
      context: context, 
      initialTime: new TimeOfDay.now());
    if(timepicked != null) {
      setState(() {
        _selectedTime = timepicked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              "Add new task", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 24
              ),
              CustomTextField(labelText: 'Enter task name'),
              SizedBox(height: 12),
            CustomDateTimePicker(
              icon: Icons.date_range,
              onPressed: _pickDate,
              value: _selectedDate,
            ),
            CustomDateTimePicker(
              icon: Icons.access_time,
              onPressed: _pickTime,
              value: _selectedTime,
            ),
            SizedBox(
              height: 24
              ),
              CustomModalActionButton(
                onClose: () {
            Navigator.of(context).pop();
          }, onSave: () {},
          )
          ],
        ),
    );
  }
}