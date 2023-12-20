import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _output = "0";
  String _input = "";
  String _equation = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _input = "";
      _output = "0";
      _equation = "";
      _num1 = 0;
      _num2 = 0;
      _operator = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "x" ||
        buttonText == "/") {
      if (_input.isNotEmpty) {
        _num1 = double.parse(_input);
        _operator = buttonText;
        _equation = '$_equation $_num1 $_operator';
        _input = "";
      }
    } else if (buttonText == "=") {
      if (_input.isNotEmpty && _operator.isNotEmpty) {
        _num2 = double.parse(_input);
        _equation = '$_equation $_num2 =';
        if (_operator == "+") {
          _input = (_num1 + _num2).toString();
        } else if (_operator == "-") {
          _input = (_num1 - _num2).toString();
        } else if (_operator == "x") {
          _input = (_num1 * _num2).toString();
        } else if (_operator == "/") {
          if (_num2 != 0) {
            _input = (_num1 / _num2).toString();
          } else {
            _input = "Erreur";
          }
        }
        _operator = "";
      }
    } else if (buttonText == "c") {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
      }
    } else {
      _input += buttonText;
    }

    setState(() {
      _output = _input;
    });
  }

  Widget _buildButton(String buttonText, double buttonHeight) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
        ),
        onPressed: () {
          _buttonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 50.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculatrice Flutter"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 5.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _output,
                  style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  _equation,
                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildButton("7", 1),
                  _buildButton("8", 1),
                  _buildButton("9", 1),
                  _buildButton("/", 1),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("4", 1),
                  _buildButton("5", 1),
                  _buildButton("6", 1),
                  _buildButton("x", 1),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("1", 1),
                  _buildButton("2", 1),
                  _buildButton("3", 1),
                  _buildButton("+", 1),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("c", 1),
                  _buildButton("0", 1),
                  _buildButton("=", 1),
                  _buildButton("-", 1),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
