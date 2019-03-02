import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent,
          brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator App",
      home: SIForm()));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _minimumPadding = 5.0;
  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text("Simple Interest Calculator",
              style: TextStyle(color: Colors.white))),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: principalControlled,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter Principal Amount";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Principal',
                            hintText: 'Enter a Principal e.g. 15000',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))))),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: roiControlled,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter valid rate";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Rate of Interest',
                            hintText: 'In Percent',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))))),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                controller: termControlled,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Please enter Term";
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Term',
                                    hintText: 'Time In Years',
                                    labelStyle: textStyle,
                                    errorStyle: TextStyle(
                                        color: Colors.yellowAccent,
                                        fontSize: 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))))),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColorDark,
                              child: Text(
                                'Calculate',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    this.displayResult =
                                        _calculateTotalReturns();
                                  }
                                });
                              }),
                        ),
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                'Reset',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  _reset();
                                });
                              }),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.all(_minimumPadding * 2),
                    child: Text(this.displayResult, style: textStyle))
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/index.png');
    Image image = Image(
        image: assetImage,
      height: 150.0,
      width: 300.0,
    );

    return Container(
        child: image, margin: EdgeInsets.all(_minimumPadding * 10));
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiControlled.text);
    double term = double.parse(termControlled.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalControlled.text = '';
    roiControlled.text = '';
    termControlled.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
