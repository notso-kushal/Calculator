import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:math_expressions/math_expressions.dart';
// त्रुटि

class Mycalculator extends StatefulWidget {
  const Mycalculator({super.key});

  @override
  State<Mycalculator> createState() => _MycalculatorState();
}

Color _textColor = Colors.white;
Color _scaffoldBgcolor = const Color(0xFF22252D);
Color _buttonColor = const Color(0xFF272B33);
Color _contColor = const Color(0xFF292D36);
bool switchVal = false;
bool val1 = false;
Color _langbutColor = const Color(0xFF272B33);
String _fontFamily = 'poppins';

class _MycalculatorState extends State<Mycalculator> {
  var userInput = '';
  var answer = '';

  String evaluateExpression(String expression) {
    Parser parser = Parser();
    Expression exp = parser.parse(expression);
    ContextModel contextModel = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, contextModel);
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: _scaffoldBgcolor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: FlutterSwitch(
            width: 80,
            duration: const Duration(seconds: 1),
            inactiveText: 'Night Mode',
            valueFontSize: 8,
            inactiveTextColor: const Color(0xFFFFDF5D),
            activeText: 'Light Mode',
            activeTextColor: const Color(0xFF6E40C9),
            showOnOff: true,
            activeToggleColor: const Color(0xFFFFDF5D),
            inactiveToggleColor: const Color(0xFF6E40C9),
            activeColor: const Color(0xFFFFDF5D),
            inactiveColor: const Color(0xFF6E40C9),
            value: switchVal,
            activeIcon: const Icon(
              Icons.wb_sunny,
              color: Colors.white,
            ),
            inactiveIcon: const Icon(
              Icons.nightlight_round,
              color: Colors.white,
            ),
            onToggle: (val) {
              setState(() {
                switchVal = val;

                if (val) {
                  _textColor = Colors.black;
                  _scaffoldBgcolor = Colors.white;
                  _buttonColor = const Color(0xFFF9F9F9);
                  _contColor = const Color(0xFFF8F8F8);
                  _langbutColor = const Color(0xFFF9F9F9);
                } else {
                  _textColor = Colors.white;
                  _contColor = const Color(0xFF292D36);
                  _buttonColor = const Color(0xFF272B33);
                  _scaffoldBgcolor = const Color(0xFF22252D);
                  _langbutColor = const Color(0xFF272B33);
                }
              });
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FlutterSwitch(
              toggleSize: 40,
              height: 40,
              width: 40,
              activeToggleColor: Colors.transparent,
              inactiveToggleColor: Colors.transparent,
              activeColor: _langbutColor,
              inactiveColor: _langbutColor,
              value: val1,
              activeIcon: const Image(image: AssetImage("images/nepal.png")),
              inactiveIcon: const Image(image: AssetImage("images/united-kingdom.png")),
              onToggle: (value) {
                setState(() {
                  val1 = value;
                  if (value) {
                    _fontFamily = 'nep';
                  } else {
                    _fontFamily = 'poppins';
                  }
                });
              },
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 40, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  textAlign: TextAlign.end,
                  userInput,
                  style: TextStyle(
                    fontSize: 18,
                    color: _textColor,
                    letterSpacing: 1,
                    fontFamily: _fontFamily,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  textAlign: TextAlign.end,
                  answer,
                  style: TextStyle(
                      fontSize: 40,
                      color: _textColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      fontFamily: _fontFamily),
                ),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  color: _contColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
              height: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        backgroundColor: _buttonColor,
                        onPressed: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        child: const Text("AC",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF26EFCB))),
                      ),
                      FloatingActionButton(
                        backgroundColor: _buttonColor,
                        onPressed: () {
                          setState(() {
                            if (userInput.isNotEmpty) {
                              if (userInput.startsWith('-')) {
                                userInput = userInput.substring(1);
                              } else {
                                userInput = '-$userInput';
                              }
                            }
                          });
                        },
                        child: const Text("+/-",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF26EFCB))),
                      ),
                      FloatingActionButton(
                        backgroundColor: _buttonColor,
                        onPressed: () {
                          setState(() {
                            if (userInput.isNotEmpty) {
                              double number = double.tryParse(userInput) ?? 0;
                              number /= 100;
                              userInput = number.toString();
                              answer = number.toString();
                            }
                          });
                        },
                        child: const Text("%",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF26EFCB))),
                      ),
                      FloatingActionButton(
                        backgroundColor: _buttonColor,
                        onPressed: () {
                          setState(() {
                            if (userInput.isNotEmpty) {
                              userInput += '÷';
                            }
                          });
                        },
                        child: const Text("÷",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFEC6666))),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        backgroundColor: _buttonColor,
                        onPressed: () {
                          setState(() {
                            if (userInput == answer || answer == '-') {
                              userInput = '';
                              answer = '';
                            }
                            userInput += '7';
                          });
                        },
                        child: Text("7",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: _textColor, fontFamily: _fontFamily)),
                      ),
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            if (userInput == answer || answer == '-') {
                              userInput = '';
                              answer = '';
                            }
                            userInput += '8';
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: Text("8",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: _textColor, fontFamily: _fontFamily)),
                      ),
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            if (userInput == answer || answer == '-') {
                              userInput = '';
                              answer = '';
                            }
                            userInput += '9';
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: Text("9",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: _textColor, fontFamily: _fontFamily)),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            if (userInput.isNotEmpty) {
                              userInput += 'x';
                            }
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: const Text("x",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEC6666),
                                fontFamily: 'poppins')),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            if (userInput == answer || answer == '-') {
                              userInput = '';
                              answer = '';
                            }
                            userInput += '4';
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: Text("4",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: _textColor, fontFamily: _fontFamily)),
                      ),
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            if (userInput == answer || answer == '-') {
                              userInput = '';
                              answer = '';
                            }
                            userInput += '5';
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: Text("5",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: _textColor, fontFamily: _fontFamily)),
                      ),
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            if (userInput == answer || answer == '-') {
                              userInput = '';
                              answer = '';
                            }
                            userInput += '6';
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: Text("6",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: _textColor, fontFamily: _fontFamily)),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            if (userInput.isNotEmpty) {
                              userInput += '-';
                            }
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: const Text("-",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFEC6666))),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            if (userInput == answer || answer == '-') {
                              userInput = '';
                              answer = '';
                            }
                            userInput += '1';
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: Text("1",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: _textColor, fontFamily: _fontFamily)),
                      ),
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            if (userInput == answer || answer == '-') {
                              userInput = '';
                              answer = '';
                            }
                            userInput += '2';
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: Text("2",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: _textColor, fontFamily: _fontFamily)),
                      ),
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            if (userInput == answer || answer == '-') {
                              userInput = '';
                              answer = '';
                            }
                            userInput += '3';
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: Text("3",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: _textColor, fontFamily: _fontFamily)),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            userInput += '+';
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: const Text("+",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEC6666),
                                fontFamily: 'poppins')),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            userInput = userInput.substring(0, userInput.length - 1);
                          });
                        },
                        backgroundColor: _buttonColor,
                        child:
                            Text("↺", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _textColor)),
                      ),
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            if (userInput == answer || answer == '-') {
                              userInput = '';
                              answer = '';
                            }
                            userInput += '0';
                          });
                        },
                        backgroundColor: _buttonColor,
                        child: Text("0",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: _textColor, fontFamily: _fontFamily)),
                      ),
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          setState(() {
                            if (userInput.isNotEmpty && !userInput.contains('.')) {
                              userInput += '.';
                            }
                          });
                        },
                        backgroundColor: _buttonColor,
                        child:
                            Text(".", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _textColor)),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            userInput = userInput.replaceAll('x', '*');
                            userInput = userInput.replaceAll('÷', '/');

                            try {
                              answer = evaluateExpression(userInput);
                              userInput = answer;
                            } catch (e) {
                              answer = '-';
                            }
                          });
                        },
                        backgroundColor: switchVal ? const Color(0xFF272B33) : const Color(0xFFF9F9F9),
                        child: const Text("=",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFEC6666),
                            )),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
