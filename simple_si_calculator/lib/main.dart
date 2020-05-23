import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final double _minPadding = 5.0;

  var _currentItemSelected = 'Rupees';

  String displayResult = "";

  TextEditingController principleController = new TextEditingController();
  TextEditingController roiController = new TextEditingController();
  TextEditingController termController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: TextFormField(
                  controller: principleController,
                  // ignore: missing_return
                  validator: (String value) {
                    if(value.isEmpty) {
                      return 'Please enter principle amount';
                    }
                  },
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  decoration: InputDecoration(
                      labelText: 'Principle',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                      hintText: 'Enter Principle e.g. 12000',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: TextFormField(
                  controller: roiController,
                  validator: (String value) {
                    if(value.isEmpty) {
                      return 'Please Enter rate of Interest';
                    }
                  },
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'In percentage',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: termController,
                        validator: (String value) {
                          if(value.isEmpty) {
                            return 'Please enter term';
                          }
                        },
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        decoration: InputDecoration(
                            labelText: 'Term',
                            hintText: 'Time in years',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Container(
                      width: _minPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {

                          setState(() {
                            if(_formKey.currentState.validate())
                              this.displayResult = _calculateTotalReturns();
                          });
                        },
                      ),
                    ),
                    Container(
                      width: _minPadding * 5,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: Text(
                  this.displayResult,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/calculator.jpg');
    Image image = Image(
      image: assetImage,
      width: 250.0,
      height: 250.0,
    );

    var _minPadding = 5.0;
    return Container(
      child: image,
      margin: EdgeInsets.all(_minPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principle = double.parse(principleController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principle + (principle * roi * term) / 100;

    return "After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected";
  }

  void _reset() {
    principleController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
