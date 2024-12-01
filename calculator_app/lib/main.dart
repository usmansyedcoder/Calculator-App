import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '0';
  String operator = '';
  double firstNum = 0;
  double secondNum = 0;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Clear all values
        input = '';
        result = '0';
        operator = '';
        firstNum = 0;
        secondNum = 0;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        // When an operator is pressed
        if (input.isNotEmpty) {
          firstNum = double.tryParse(input) ?? 0;
          operator = buttonText;
          input += " $buttonText "; // Show operator in the input
          result = input;
        }
      } else if (buttonText == "=") {
        // When '=' is pressed
        List<String> parts = input.split(' ');
        if (parts.length == 3) {
          firstNum = double.tryParse(parts[0]) ?? 0;
          operator = parts[1];
          secondNum = double.tryParse(parts[2]) ?? 0;

          switch (operator) {
            case "+":
              result = (firstNum + secondNum).toString();
              break;
            case "-":
              result = (firstNum - secondNum).toString();
              break;
            case "×":
              result = (firstNum * secondNum).toString();
              break;
            case "÷":
              result = (secondNum != 0)
                  ? (firstNum / secondNum).toString()
                  : "Error";
              break;
            default:
              result = '0';
          }
          input = result; // Update input to the result
        }
      } else {
        // For numbers and other inputs
        input += buttonText;
        result = input;
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                result,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("÷"),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("×"),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-"),
                  ],
                ),
                Row(
                  children: [
                    buildButton("C"),
                    buildButton("0"),
                    buildButton("="),
                    buildButton("+"),
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
