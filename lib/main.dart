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
      title: 'Basic Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';

  double? firstNumber;
  String? selectedOperator;

  void numberPressed(String number) {
    setState(() {
      if (display == '0' || display == 'Error') {
        display = number;
      } else {
        display += number;
      }
    });
  }

  void decimalPressed() {
    setState(() {
      if (!display.contains('.') && display != 'Error') {
        display += '.';
      }
    });
  }

  void operatorPressed(String operator) {
    setState(() {
      firstNumber = double.tryParse(display);

      if (firstNumber != null) {
        selectedOperator = operator;
        display = '0';
      }
    });
  }

  void calculate() {
    if (firstNumber == null || selectedOperator == null) {
      return;
    }

    final secondNumber = double.tryParse(display) ?? 0;

    double result;

    switch (selectedOperator) {
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
          setState(() {
            display = 'Error';
            firstNumber = null;
            selectedOperator = null;
          });
          return;
        }

        result = firstNumber! / secondNumber;
        break;

      default:
        return;
    }

    setState(() {
      if (result == result.toInt()) {
        display = result.toInt().toString();
      } else {
        display = result.toString();
      }

      firstNumber = null;
      selectedOperator = null;
    });
  }

  void clear() {
    setState(() {
      display = '0';
      firstNumber = null;
      selectedOperator = null;
    });
  }

  Widget calculatorButton(
      String text, {
        VoidCallback? onPressed,
        bool isOperator = false,
      }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          height: 65,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
              isOperator ? Colors.indigo : Colors.grey.shade200,
              foregroundColor:
              isOperator ? Colors.white : Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Basic Calculator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        display,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    calculatorButton(
                      '7',
                      onPressed: () => numberPressed('7'),
                    ),
                    calculatorButton(
                      '8',
                      onPressed: () => numberPressed('8'),
                    ),
                    calculatorButton(
                      '9',
                      onPressed: () => numberPressed('9'),
                    ),
                    calculatorButton(
                      '÷',
                      isOperator: true,
                      onPressed: () => operatorPressed('÷'),
                    ),
                  ],
                ),

                Row(
                  children: [
                    calculatorButton(
                      '4',
                      onPressed: () => numberPressed('4'),
                    ),
                    calculatorButton(
                      '5',
                      onPressed: () => numberPressed('5'),
                    ),
                    calculatorButton(
                      '6',
                      onPressed: () => numberPressed('6'),
                    ),
                    calculatorButton(
                      '×',
                      isOperator: true,
                      onPressed: () => operatorPressed('×'),
                    ),
                  ],
                ),

                Row(
                  children: [
                    calculatorButton(
                      '1',
                      onPressed: () => numberPressed('1'),
                    ),
                    calculatorButton(
                      '2',
                      onPressed: () => numberPressed('2'),
                    ),
                    calculatorButton(
                      '3',
                      onPressed: () => numberPressed('3'),
                    ),
                    calculatorButton(
                      '-',
                      isOperator: true,
                      onPressed: () => operatorPressed('-'),
                    ),
                  ],
                ),

                Row(
                  children: [
                    calculatorButton(
                      'C',
                      isOperator: true,
                      onPressed: clear,
                    ),
                    calculatorButton(
                      '0',
                      onPressed: () => numberPressed('0'),
                    ),
                    calculatorButton(
                      '.',
                      onPressed: decimalPressed,
                    ),
                    calculatorButton(
                      '+',
                      isOperator: true,
                      onPressed: () => operatorPressed('+'),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '=',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}