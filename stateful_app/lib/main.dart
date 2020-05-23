import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        title: "Stateful App Example",
        home: FavoriteCity(),
      )
  );
}

class FavoriteCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FavoriteCityState();
    throw UnimplementedError();
  }
}

class _FavoriteCityState extends State<FavoriteCity> {
  String nameCity = "";
  var _currencies = ['Rupees', 'Dollar', 'Pounds', 'Others'];
  var _currSelected = 'Rupees';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text("Stateful App Example"),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  onSubmitted: (String userInput) {
                    setState(() {
                      nameCity = userInput;
                    });
                  },
                ),
                DropdownButton<String> (
                  items: _currencies.map((String dropDownStringItem) {
                    return DropdownMenuItem<String> (
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),

                  onChanged: (String newValueSelected) {
                    _onDropDownItemSelected(newValueSelected);

                  },

                  value: _currSelected,
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    "Your best city is $nameCity",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                )
              ],
            ),
        )
    );
  }
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currSelected = newValueSelected;
    });
  }
}
