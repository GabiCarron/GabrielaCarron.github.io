import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  bool shouldReset = false;

  void buttonPressed(String buttonText) {
    if (buttonText == "Limpar") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "⌫") {
      if (_output.isNotEmpty) {
        if (_output.endsWith(" ")) {
          _output = _output.substring(0, _output.length - 3); // Remove operand and spaces
        } else {
          _output = _output.substring(0, _output.length - 1);
        }
        if (_output.isEmpty || _output == " ") {
          _output = "0";
        }
      }
    } else if (buttonText == ",") {
      if (!_output.split(' ').last.contains(".")) {
        _output += ".";
      }
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
      if (operand.isNotEmpty && !shouldReset) {
        buttonPressed("=");
      }
      num1 = double.parse(_output.split(' ').last);
      operand = buttonText;
      _output += " $operand ";
      shouldReset = false;
    } else if (buttonText == "=") {
      num2 = double.parse(_output.split(' ').last);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "x") {
        _output = (num1 * num2).toString();
      } else if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      num1 = 0;
      num2 = 0;
      operand = "";
      shouldReset = true;
    } else {
      if (shouldReset) {
        _output = buttonText;
        shouldReset = false;
      } else {
        _output += buttonText;
        if (_output.startsWith("0") && !_output.contains(".")) {
          _output = _output.substring(1);
        }
      }
    }

    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              output,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("/"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("x"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("0"),
                    buildButton(","),
                    buildButton("="),
                    buildButton("+"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("Limpar"),
                    buildButton("⌫"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
