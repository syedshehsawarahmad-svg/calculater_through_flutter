import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0';
  double? firstNumber;
  String operator = '';

  void numberPressed(String number) {
    setState(() {
      if (display == '0') {
        display = number;
      } else {
        display += number;
      }
    });
  }

  void operatorPressed(String op) {
    setState(() {
      firstNumber = double.tryParse(display);
      operator = op;
      display = '0';
    });
  }

  void calculate() {
    if (firstNumber == null || operator.isEmpty) return;

    double secondNumber = double.tryParse(display) ?? 0;
    double result = 0;

    switch (operator) {
      case '+':
        result = firstNumber! + secondNumber;
        break;
      case '-':
        result = firstNumber! - secondNumber;
        break;
      case '×':
        result = firstNumber! * secondNumber;
        break;
      case '÷':
        if (secondNumber == 0) {
          display = 'Error';
          firstNumber = null;
          operator = '';
          return;
        }
        result = firstNumber! / secondNumber;
        break;
    }

    setState(() {
      display = result.toString();
      if (display.endsWith('.0')) {
        display = display.substring(0, display.length - 2);
      }
      firstNumber = null;
      operator = '';
    });
  }

  void clear() {
    setState(() {
      display = '0';
      firstNumber = null;
      operator = '';
    });
  }

  Widget button(String text, {VoidCallback? onPressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(25),
              child: Text(
                display,
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Row(
            children: [
              button('7', onPressed: () => numberPressed('7')),
              button('8', onPressed: () => numberPressed('8')),
              button('9', onPressed: () => numberPressed('9')),
              button('÷', onPressed: () => operatorPressed('÷')),
            ],
          ),

          Row(
            children: [
              button('4', onPressed: () => numberPressed('4')),
              button('5', onPressed: () => numberPressed('5')),
              button('6', onPressed: () => numberPressed('6')),
              button('×', onPressed: () => operatorPressed('×')),
            ],
          ),

          Row(
            children: [
              button('1', onPressed: () => numberPressed('1')),
              button('2', onPressed: () => numberPressed('2')),
              button('3', onPressed: () => numberPressed('3')),
              button('-', onPressed: () => operatorPressed('-')),
            ],
          ),

          Row(
            children: [
              button('C', onPressed: clear),
              button('0', onPressed: () => numberPressed('0')),
              button('=', onPressed: calculate),
              button('+', onPressed: () => operatorPressed('+')),
            ],
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }
}