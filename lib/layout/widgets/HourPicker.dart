import 'package:flutter/material.dart';

class HourPicker extends StatefulWidget {
  @override
  _HourPickerState createState() => _HourPickerState();
}

class _HourPickerState extends State<HourPicker> {
  List<String> hourList = [
    '1:00',
    '2:00',
    '3:00',
    '4:00',
    '5:00',
    '6:00',
    '7:00',
    '8:00',
    '9:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00',
    '24:00'
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Godzina',
        textAlign: TextAlign.center,
      ),
      content: Container(
        width: 100,
        height: 150,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: hourList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  hourList[index],
                  textAlign: TextAlign.center,
                ),
                onTap: () => {Navigator.of(context).pop()},
              );
            }),
      ),
    );
  }
}
